require 'set'
require 'json'
require 'riak'

require_relative File.join('hanover', 'version')

module Hanover
  # Your code goes here...
end

%w{g_set two_p_set g_counter persistence}.each do |f|
  require_relative File.join('hanover', f)
end
