# connect firehose.io via after :save callback/hook
require 'net/http'

class Message
  after :save do

    if to =~ /^#/ 
      # channels
      stream = "c/"+ to[1..-1]
    else 
      # users
      stream = "u/"+ to
    end
    p [stream, content]

    req = Net::HTTP::Put.new("/chat/#{stream}.json")
    req.body = to_json
    Net::HTTP.start('127.0.0.1',7474).request(req)
  end
end
