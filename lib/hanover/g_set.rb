module Hanover
  class GSet
    attr_accessor :members
    def initialize
      self.members = Set.new
    end
    
    def add(atom)
      self.members.add atom
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