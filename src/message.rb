require 'data_mapper'
require 'dm-sqlite-adapter'
require 'dm-migrations'

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
