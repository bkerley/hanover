require_relative 'helper'

class TwoPSetTest < HanoverCase
  def setup
    @subject = TwoPSet.new
  end
  def test_support_adding_and_removing
    @subject.add :alpha
    @subject.add :bravo
    
    assert_includes @subject, :alpha
    assert_includes @subject, :bravo
    
    @subject.remove :bravo
    
    refute_includes @subject, :bravo
  end
  
  def test_merge
    other = @subject.class.new

    @subject.add 'echo'
    other.add 'foxtrot'
    @subject.add 'george'
    other.remove 'george'

    assert_includes @subject.members, 'george'

    @subject.merge other

    assert_includes @subject, 'echo'
    assert_includes @subject, 'foxtrot'

    refute_includes @subject, 'george'
  end
  
  def test_round_trip_from_json
    @subject.add 'charlie'
    @subject.add 'delta'
    @subject.remove 'delta'

    j = @subject.to_json
    other = @subject.class.from_json j

    assert_equal @subject.members, other.members
  end
end