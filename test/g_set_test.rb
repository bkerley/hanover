require_relative 'helper'

class GSetTest < HanoverCase
  context 'GSet' do
    subject { GSet.new }
    should 'have entries after addition' do
      subject.add :alpha
      subject.add :bravo
      
      assert_includes subject.members, :alpha
      assert_includes subject.members, :bravo
    end
    
    should 'merge' do
      other = GSet.new
      
      subject.add :charlie
      other.add :delta
      
      subject.merge other
      
      assert_includes subject.members, :charlie
      assert_includes subject.members, :delta
    end
  end
end