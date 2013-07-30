require 'minitest/autorun'
require 'minitest/pride'

require_relative File.join('..', 'lib', 'hanover')

class HanoverCase < Minitest::Test
  include Hanover
end