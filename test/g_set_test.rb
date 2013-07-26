require_relative 'helper'

class GSetTest < HanoverCase
  def setup
    @subject = GSet.new
  end

  def test_has_entries_after_addition
    @subject.add :alpha
    @subject.add :bravo

    assert_includes @subject, :alpha
    assert_includes @subject, :bravo
  end

  def test_merge
    other = GSet.new

    @subject.add :charlie
    other.add :delta

    @subject.merge other

    assert_includes @subject, :charlie
    assert_includes @subject, :delta
  end

  def test_json_round_trip
    @subject.add 'echo'
    @subject.add 'foxtrot'
    @subject.add 7

    j = @subject.to_json
    other = GSet.from_json j
    assert_equal @subject.members, other.members
  end
end