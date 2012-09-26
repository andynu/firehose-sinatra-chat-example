#!/usr/bin/env ruby
#
# Firehose hooked into DataMapper
#

require 'datamapper'
require 'dm-sqlite-adapter'
require 'dm-migrations'
require 'net/http'

# DataMapper Setup
DB_FILE = File.expand_path("../../chat.db",__FILE__)
DM_DSN = "sqlite://#{DB_FILE}"

puts DM_DSN

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, DM_DSN)

# Simple message class
class Message
  include DataMapper::Resource
  property :id, Serial
  property :from, String
  property :to, String
  property :content, Text
  property :created_at, DateTime
end
DataMapper.finalize

#---
# connect firehose.io via after :save callback/hook

class Message
  after :save do

    if to =~ /^#/ # channels
      stream = "c/"+ to[1..-1]
    else # users
      stream = "u/"+ to
    end

    p stream

    req = Net::HTTP::Put.new("/chat/#{stream}.json")
    req.body = to_json
    Net::HTTP.start('127.0.0.1',7474).request(req)
  end
end

#---

class DmExample
  def initialize
    Message.create(
      from: self.class.name,
      to: "#system",
      content: "Starting up!"
    )
  end

  def run
    Message.all.each do |m|
      puts m.to_json
    end
  end
end


#---

if $0 == __FILE__
  if ARGV[0] == "--reset"
    DataMapper.auto_migrate!
  end
  if ARGV[0] == "--migrate"
    DataMapper.auto_upgrade!
  end

  DmExample.new.run
end
