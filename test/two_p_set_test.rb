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
    
    should 'merge' do
      other = subject.class.new
      
      subject.add 'echo'
      other.add 'foxtrot'
      subject.add 'george'
      other.remove 'george'
      
      assert_includes subject.members, 'george'
      
      subject.merge other
      
      assert_includes subject.members, 'echo'
      assert_includes subject.members, 'foxtrot'
      
      refute_includes subject.members, 'george'
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