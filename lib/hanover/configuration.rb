module Hanover
  class Configuration
    def self.client
      Riak::Client.new(:host => "33.33.33.11", :http_port => 8111)
    end
  end
end