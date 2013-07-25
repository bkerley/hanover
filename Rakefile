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

task :test, [:host, :port] => :riak_running

task :riak_running, [:host, :port] do |task, args|
  host = args.host || "localhost"
  port = args.port || 8091
  begin
    sh "curl -s #{host}:#{port} > /dev/null"
  rescue => e
    puts "Couldn't see that Riak is running on #{host} port #{port}. Sad trombone. :("
    raise e
  end
end