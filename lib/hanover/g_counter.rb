module Hanover
  class GCounter
    attr_accessor :counts
    def initialize
      self.counts = Hash.new{0}
    end
    
    def to_json
      {
        type: 'GCounter',
        c: counts
        }.to_json
    end
    
    def self.from_json(json)
      # don't symbolize keys
      h = JSON.parse json
      raise ArgumentError.new 'unexpected type field in JSON' unless h['type'] == 'GCounter'

      gc = new
      gc.counts = h['c']
      return gc
    end
    
    def increment
      counts[tag] += 1
    end
    
    def value
      counts.values.inject(0, &:+)
    end
    
    def merge(other)
      new_keys = Set.new
      new_keys.merge counts.keys
      new_keys.merge other.counts.keys
      
      new_keys.each do |k|
        counts[k] = [counts[k], other.counts[k]].max
      end
    end
    
    def tag
      radix = 36
      [
        object_id.to_s(radix),
        Process.uid.to_s(radix), 
        Process.gid.to_s(radix), 
        Process.pid.to_s(radix), 
        `hostname`.strip
        ].join
    end
  end
end