#!/usr/bin/env rake
require 'rake'
require 'rake/testtask'
require "bundler/gem_tasks"
require 'minitest/autorun'

task :default => :test

Rake::TestTask.new(:test) do |test|
  test.libs << 'test'
  test.pattern = 'test/*_test.rb'
  test.test_files = FileList['test/*_test.rb']
  test.verbose = true
  p test.inspect
end

task :test

# task :test, [:host, :port] => :riak_running

# task :riak_running, [:host, :port] do |task, args|
#   host = args.host || "localhost"
#   port = args.port || 8091
#   begin
#     sh "curl -s #{host}:#{port} > /dev/null"
#   rescue => e
#     puts "Couldn't see that Riak is running on #{host} port #{port}. Sad trombone. :("
#     raise e
#   end
# end