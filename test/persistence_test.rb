require_relative 'helper'

class PersistenceTest < HanoverCase
  context 'the Persistence class' do
    subject { Persistence }
    
    should 'wrap a CRDT' do
      wrapped = Persistence.new GSet.new

      assert wrapped.key
      assert_kind_of GSet, wrapped.content
    end
    
    should 'load successfully' do
      wrapped = Persistence.new GSet.new
      
      found = Persistence.find wrapped.key
      
      assert_equal wrapped.key, found.key
    end
  end
  
  context 'a wrapped GSet' do
    subject { Persistence.new GSet.new }

    should 'name itself'
    should 'delegate adding elements to the set'
    should 'support parallel adds consistently'
    should 'save after add'
  end
end