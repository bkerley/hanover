require_relative 'helper'

class GCounterTest < HanoverCase
  context 'GCounter' do
    subject { GCounter.new }

    should 'increment' do
      assert_equal 0, subject.value
      
      subject.increment
      subject.increment
      
      assert_equal 2, subject.value
    end
    
    should 'merge' do
      other = subject.class.new
      subject.increment
      other.increment
      
      subject.merge other
      
      assert_equal 2, subject.value
    end
    
    should 'round trip from JSON' do
      subject.increment
      subject.increment
      
      j = subject.to_json
      other = subject.class.from_json j
      
      assert_equal 2, other.value
    end
  end
end