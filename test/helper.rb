require 'minitest/autorun'

require_relative File.join('..', 'lib', 'hanover')

class HanoverCase < Minitest::Test
  include Hanover
end