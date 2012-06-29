require 'shoulda-context'
require 'minitest/autorun'

require_relative File.join('..', 'lib', 'hanover')

class HanoverCase < MiniTest::Unit::TestCase
  include Shoulda::Context::Assertions
  include Shoulda::Context::InstanceMethods
  extend Shoulda::Context::ClassMethods
  
  include Hanover
end