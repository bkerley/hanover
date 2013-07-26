require_relative 'helper'

class GCounterTest < HanoverCase
  def setup
    @subject = GCounter.new
  end

  def test_increment
    assert_equal 0, @subject.value

    @subject.increment
    @subject.increment

    assert_equal 2, @subject.value
  end
  def test_merge
    other = @subject.class.new
    @subject.increment
    other.increment

    @subject.merge other
    assert_equal 2, @subject.value
  end
    
  def test_round_trip_from_json
    @subject.increment
    @subject.increment

    j = @subject.to_json
    other = @subject.class.from_json j
    assert_equal 2, other.value
  end
end