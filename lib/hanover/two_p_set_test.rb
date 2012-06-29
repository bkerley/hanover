module Hanover
  class TwoPSet
    attr_accessor :added, :removed
    
    def initialize
      self.added = GSet.new
      self.removed = GSet.new
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
      self.added.merge other.removed
    end
    
    def to_json
      {
        type: '2pSet',
        a: self.added,
        r: self.removed
        }.to_json
    end
  end
end