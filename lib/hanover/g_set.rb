module Hanover
  class GSet
    attr_accessor :members
    def initialize
      self.members = Set.new
    end
    
    def self.from_json(json)
      h = JSON.parse json, symbolize_names: true
      raise ArgumentError.new 'unexpected type field in JSON' unless h[:type] == 'GSet'
      
      gs = new
      gs.members.merge h[:a]
      
      return gs
    end
    
    def add(atom)
      self.members.add atom
    end
    
    def include?(atom)
      self.members.include? atom
    end
    
    def to_json
      {
        type: 'GSet',
        a: self.members.to_a
        }.to_json
    end
    
    def merge(other)
      self.members.merge other.members
    end
  end
end