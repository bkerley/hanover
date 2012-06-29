require_relative 'helper'

class TwoPSetTest < HanoverCase
  context 'TwoPSet' do
    subject { TwoPSet.new }
    
    should 'support adding and removing' do
      subject.add :alpha
      subject.add :bravo
      
      assert_includes subject.members, :alpha
      assert_includes subject.members, :bravo
      
      subject.remove :bravo
      
      refute_includes subject.members, :bravo
    end
    
    should 'round trip from JSON' do
      subject.add 'charlie'
      subject.add 'delta'
      subject.remove 'delta'
      
      j = subject.to_json
      other = subject.class.from_json j
      
      assert_equal subject.members, other.members
    end
  end
end