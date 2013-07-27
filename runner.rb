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