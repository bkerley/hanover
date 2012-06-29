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
  end
end