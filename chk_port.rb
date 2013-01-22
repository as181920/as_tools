# encoding: utf-8
require 'socket'
require 'timeout'

def port_open?(ip, port, seconds=1)
  Timeout::timeout(seconds) do
    begin
      TCPSocket.new(ip, port).close
      true
    rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
      false
    end
  end
rescue Timeout::Error
  false
end


#  commond line ...
unless ARGV.length >= 2 then
  puts <<-USAGE
Usage: ruby  chk_port.rb ip port [timeout_seconds]
Examples: ruby ckh_port.rb "www.micro-notes.com" 3333
  USAGE
else
  ip = ARGV[0].to_s
  port = ARGV[1].to_i
  seconds = ARGV[2].to_i
  puts port_open? ip, port, seconds
end

