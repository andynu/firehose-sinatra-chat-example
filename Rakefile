#!/usr/bin/env ruby
#
# Firehose hooked into DataMapper
#

# connect firehose.io via after :save callback/hook

src = File.expand_path("../src",__FILE__)
$:.push src unless $:.include? src

require 'message'
require 'message-firehose-callback'

namespace :db do

  desc "Creates a fresh chat.db sqlite database"
  task :create do
    DataMapper.auto_migrate!
  end

  desc "Upgrades the chat.db sqlite database"
  task :migrate do
    DataMapper.auto_upgrade!
  end

end
