#!/usr/bin/env rake
require 'rake'
require 'rake/testtask'
require "bundler/gem_tasks"

task :default => :test

Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/*_test.rb'
  test.verbose = true
end

task :test => :riak_running

task :riak_running do
  begin
    sh 'curl -s localhost:8091 > /dev/null'
  rescue => e
    puts "Couldn't see that Riak is running on port 8091. Sad trombone. :("
    raise e
  end
end