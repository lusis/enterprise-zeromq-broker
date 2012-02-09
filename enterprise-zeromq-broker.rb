#!/usr/bin/env ruby
require 'rubygems'
require 'ffi-rzmq'

feport = ARGV[0]
beport = ARGV[1]

context = ZMQ::Context.new

fe = context.socket(ZMQ::PULL)
be = context.socket(ZMQ::PUSH)

fe.bind("tcp://127.0.0.1:#{feport}")
be.bind("tcp://127.0.0.1:#{beport}")

loop do
  msg = ''
  fe.recv_string(msg)
  puts "got message on port #{feport}"
  be.send_string(msg)
end
