require_relative 'helper'

class PersistenceTest < HanoverCase
  def setup
    @keys = []
  end

  def test_wrap_a_crdt
    wrapped = Persistence.new(GSet.new)

    assert wrapped.key
    assert_kind_of GSet, wrapped.content
    @keys << wrapped.key
  end
  
  def test_load_successfully
    wrapped = Persistence.new(GSet.new)
    found = Persistence.find wrapped.key
    assert_equal wrapped.key, found.key
    @keys << wrapped.key
  end

#   should 'get client from configuration' do
#     fail
#   end

  def test_name_itself
    subject = Persistence.new(GSet.new)
    @keys << subject.key
    assert subject.key
  end
  
  def test_delegate_adding_elements_to_the_set
    subject = Persistence.new(GSet.new)
    subject.add 'alpha'
    subject.add 'bravo'
    @keys << subject.key

    assert_includes subject, 'alpha'
    assert_includes subject, 'bravo'
  end
  
  def test_support_parallel_adds_consistently
    subject = Persistence.new(GSet.new)
    other = Persistence.find(subject.key)

    subject.add 'alpha'
    other.add 'bravo'
    subject.reload

    third = Persistence.find(subject.key)
    @keys << subject.key << other.key << third.key

    # p subject.inspect
    assert_includes subject, 'alpha'
    assert_includes subject, 'bravo'
    assert_includes third, 'alpha'
    assert_includes third, 'bravo'
  end

  def test_adds_are_concurrent_too
    subject = Persistence.new(GSet.new)
    other = Persistence.find(subject.key)
    third = Persistence.find(subject.key)

    t1=Thread.new {subject.add 'alpha'}
    t2=Thread.new {other.add 'bravo'}
    t3=Thread.new {third.add 'charlie'}

    threads = [t1,t2,t3]
    threads.map(&:join)
    subject.reload

    @keys << subject.key << other.key << third.key

    # p subject.inspect
    assert_includes subject, 'alpha'
    assert_includes subject, 'bravo'
    assert_includes subject, 'charlie'
    assert_includes third, 'alpha'
    assert_includes third, 'bravo'
    assert_includes third, 'charlie'
  end

  def teardown
    # delete from hanover bucket
    @keys.each { |key| Persistence.client.bucket('hanover').delete(key) }
  end
end