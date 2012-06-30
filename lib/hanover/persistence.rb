module Hanover
  class Persistence < Delegator
    attr_reader :key, :content
    def initialize(content, key = nil)
      @content = content
      @key = key
      @klass = @content.class
      
      save
    end
    
    def __getobj__
      @content
    end
    
    def initialize_from_key(key)
      @key = key
      @robject = bucket.get key
      @klass = Hanover.const_get(@robject.data['type'])
      @content = @klass.from_json @robject.raw_data
      perform_merges
    end
    
    def self.find(key)
      p = allocate
      p.initialize_from_key key
      return p
    end
    
    def self.client
      return @client if defined? @client
      @client = Riak::Client.new http_port: 8091
    end
    
    private
    def save
      create unless @robject

      update
    end
    
    def create
      @robject = bucket.new @key      
      @robject.raw_data = @content.to_json
      
      @robject.store
      @key = @robject.key
    end
    
    def perform_merges
      return unless @robject.conflict?
      
       @robject.siblings.each {|s| @content.merge s.raw_data }
    end
    
    def update
      @robject.reload
      perform_merges
    end
    
    def bucket
      self.class.client.bucket 'hanover'
    end
  end
end