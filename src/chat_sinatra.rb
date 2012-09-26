#!/usr/bin/env ruby
#
#
#
src = File.expand_path("..",__FILE__)
$:.push src unless $:.include? src

require 'bundler/setup'
require 'sinatra/base'
require 'rack/firehose'
require 'message'
require 'message-firehose-callback'

class ChatSinatra < Sinatra::Base
  use Rack::Firehose

  set :root, File.expand_path("../..",__FILE__)

  get '/' do
    haml :chat
  end

  get '/js/chat.js' do
    coffee :chat
  end

  get '/css/chat.css' do
    sass :chat
  end

  get '/c/:channel.json' do
    ''
  end

  put '/c/:channel.json' do
    channel = params["channel"]

    msg = Message.create(
      from: params["from"],
      to: params["to"],
      content: params["content"]
    ).to_json

    chunk msg, :to => "/c/#{channel}.json"

    msg
  end

end
