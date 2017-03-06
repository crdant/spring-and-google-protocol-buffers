#!/usr/bin/env ruby

require './customer.pb'
require 'net/http'
require 'uri'

require 'optparse'
require 'ostruct'

options = OpenStruct.new
options.host = "localhost"
options.port = 8080

OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"

  opts.on("-h [HOST]", "--host [HOST]", "Hostname for the test service") do |host|
    options.host = host
  end

  opts.on("-p [PORT]", "--port [PORT]", "Port for the test service") do |port|
    options.port = port
  end
end.parse!

uri = URI.parse("http://#{options.host}:#{options.port}/customers/3")
body = Net::HTTP.get(uri)
puts Demo::Customer.parse(body)
