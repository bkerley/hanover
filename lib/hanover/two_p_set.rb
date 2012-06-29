module Hanover
  class TwoPSet
    attr_accessor :added, :removed
    
    def initialize
      self.added = GSet.new
      self.removed = GSet.new
    end
    
    def self.from_json(json)
      h = JSON.parse json, symbolize_names: true
      raise ArgumentError.new 'unexpected type field in JSON' unless h[:type] == 'TwoPSet'

      tps = new
      tps.added = GSet.from_json h[:a].to_json
      tps.removed = GSet.from_json h[:r].to_json
      
      return tps
    end
    
    def members
      self.added.members - self.removed.members
    end
    
    def add(atom)
      raise ArgumentError.new 'already removed' if self.removed.include? atom
      
      self.added.add atom
    end
    
    def remove(atom)
      self.removed.add atom
    end
    
    def merge(other)
      self.added.merge other.added
      self.removed.merge other.removed
    end
    
    def to_json(*args)
      {
        type: 'TwoPSet',
        a: self.added,
        r: self.removed
        }.to_json *args
    end
  end
end