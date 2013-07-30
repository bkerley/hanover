require './lib/hanover.rb'
def setup
  pgset = Hanover::Persistence.new(Hanover::GSet.new)
  other=Hanover::Persistence.find(pgset.key)
  [pgset, other]
end

def runtest(pgset, other)
  p "adding..."
  pgset.add 'alpha'
  other.add 'bravo'
  #p "robject..."
  #p pgset.robject
  p "reloading..."
  pgset.reload
end

pgset,other=setup
runtest(pgset,other)

Riak::RObject.on_conflict do |obj|
  p "in conflict resolution"
  p obj.inspect
  merged = {}
  obj.siblings.each {|sib| merged.merge!(sib.data)}
  p merged.inspect
  p "returning the new"
  obj.siblings = [merged]
  obj
end
require './lib/hanover.rb'
class Runner
  include Hanover
  attr_reader :pgset, :other

  def initialize
    @pgset = Persistence.new(GSet.new)
    @other = Persistence.find(@pgset.key)
  end

  def add_from_two(order=false)
    if order
      pgset.add "alpha"
      other.add "bravo"
    else
      other.add "alpha"
      pgset.add "bravo"
    end
  end

  def reload
    pgset.reload
  end

  def members
    pgset.members
  end

  def robject
    pgset.robject
  end
end