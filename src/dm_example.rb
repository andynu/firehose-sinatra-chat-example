#!/usr/bin/env ruby
#
# Firehose hooked into DataMapper
#

# connect firehose.io via after :save callback/hook

src = File.expand_path("..",__FILE__)
$:.push src unless $:.include? src

require 'message'
require 'message-firehose-callback'

#---

class DmExample
  def initialize
    Message.create(
      from: self.class.name,
      to: "#general",
      content: "Starting up!"
    )
  end

  def run
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
