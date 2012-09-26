require 'bundler/setup'

src = File.expand_path("../src",__FILE__)
$:.push src unless $:.include? src

require 'chat_sinatra'

#app = Rack::Builder.app do
#  use Rack::Stream
#  run ChatSinatra.new
#end
#
#run app

run ChatSinatra.new
