require 'minitest/autorun'
require 'shoulda-context'

require_relative File.join('..', 'lib', 'hanover')

class HanoverCase < Minitest::Test
  include Shoulda::Context::Assertions
  include Shoulda::Context::InstanceMethods
  extend Shoulda::Context::ClassMethods
  
  include Hanover
end