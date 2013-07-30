module Hanover
  class Persistence
    attr_reader :key, :klass
    attr_accessor :content, :robject
    def initialize(content, key = nil)
      @content = content
      @key = key
      @klass = @content.class
      save
    end
    
    def respond_to?(name)
      methods.include?(name) || @content.respond_to?(name)
    end
    
    def method_missing(name, *args, &block)
      result = @content.send name, *args, &block
      save unless @robject.raw_data == @content.to_json
      result
    end
    
    def initialize_from_key(key)
      @key = key
      @robject = bucket.get key

      get_klass
      @content = @klass.new
      perform_merges
    end
    
    def reload
      begin
        @robject.reload
      rescue Riak::Conflict
        #do nothing
      ensure
        perform_merges
      end
    end
    
    def inspect
      "#<Hanover::Persistence::0x#{object_id.to_s(16)} @key=#{@robject.key} #{@content.inspect}>"
    end
    
    def self.find(key)
      p = allocate
      p.initialize_from_key key
      return p
    end
    
    def self.client
      return @client if defined? @client
      @client = Configuration.client
    end
    
    private
    def save
      create unless @robject
      @robject.raw_data = @content.to_json
      @robject.content_type = 'application/json'
      @robject.store
      reload
    end
    
    def create
      @robject = bucket.new @key      
      @robject.raw_data = @content.to_json
      
      @robject.store
      @key = @robject.key
    end
    
    def perform_merges
      if @robject.conflict?
        content = klass.new
        @robject.siblings.each {|s| content.merge(klass.from_json(s.raw_data))}

        new_robject = Riak::RObject.new(bucket, @key)
        new_robject.data = content
        new_robject.content_type = "application/json"

        @robject.siblings = [new_robject]
        @robject.store
        @content = content
      else
        @content.merge @klass.from_json(@robject.raw_data)
      end
    end
    
    def get_klass
      if @robject.conflict?
        @klass = Hanover.const_get(@robject.siblings.first.data['type'])
      else
        @klass = Hanover.const_get(@robject.data['type'])
      end
    end
    
    def bucket
      bucket = self.class.client.bucket('hanover')
      bucket.allow_mult = true
      bucket
    end
  end
end