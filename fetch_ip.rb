#!/usr/bin/ruby
##ruby获得自己的外网IP地址
require "logger"
require 'open-uri'
require "mongo"
#require "net/smtp"
require "mail"

logger = Logger.new("ip.log", "monthly")
logger.level = Logger::DEBUG

Mail.defaults do
  delivery_method :smtp, {
    #address: "smtp.139.com",
    address: "smtp.gmail.com",
    #user_name: "13816956163@139.com",
    user_name: "as181920",
    password: "google.181920",
    authentication: "plain",
  }
end
=begin
def send_email(to, opts={})
  opts[:several] ||= "smtp.139.com"
  opts[:from] ||= "13816956163@139.com"
  opts[:from_alias] ||= "as ip notification"
  opts[:subject] ||= "ip notification"
  opts[:body] ||= "ip changed!"

  msg = <<END_OF_MESSAGE
From: #{opts[:from_alias]} <#{opts[:from]}>
To: <#{to}>
Subject: #{opts[:subject]}

#{opts[:body]}
END_OF_MESSAGE

  Net::SMTP.start(opts[:server],25,"localhost","13816956163","139_181920",:plain) do |smtp|
    smtp.send_message msg, opts[:from], to
  end
end
=end

db = Mongo::Connection.new("localhost").db("local")
collection = db.collection("local_ip")


loop do
#3.times do
  begin
    #get current IP
    #puts open('http://whois.ipcn.org/').read.scan(/<td>(\d+\.\d+\.\d+\.\d+)<\/td>/)
    last_ip = collection.find.sort(["$natural","descending"]).limit(1).first
    #print "getting ip,please wait for several seconds... "
    current_ip = (open('http://checkip.dyndns.org/').read.scan(/(\d+\.\d+\.\d+\.\d+)/))[0][0]
    collection.insert(ip: current_ip, created_at: Time.now)

    if last_ip and current_ip != last_ip["ip"] then
      #print Time.now," ip: ",current_ip,"  changed!\n"
      logger.info "#{Time.now},  IP: #{current_ip},  changed!"
      mail = Mail.deliver do
        to "13816956163@139.com"
        from "as181920@gmail.com"
        subject "ip notification"
        text_part do
          body "last_ip: #{last_ip["ip"]}, current_ip: #{current_ip}"
        end
      end
    else
      #print Time.now," ip: ",current_ip,"  remain...\n"
      logger.info "#{Time.now},  IP: #{current_ip},  remain..."
      #send_email "13816956163@139.com", body: "last_ip: #{last_ip}, current_ip: #{current_ip}"
    end

    sleep 180
  rescue => e
    #puts e
    logger.info "#{Time.now},  #{e}"
    sleep 180
  end
end

