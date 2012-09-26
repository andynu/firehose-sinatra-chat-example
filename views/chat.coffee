# underscore.js with {{mustash}} style!
_.templateSettings =
    interpolate : /\{\{(.+?)\}\}/g

message_template = _.template """
<li class='message'>
  <div class='from'>{{from}}</div>
  <div class='content'>{{content}}</div>
</li>
"""

d = (o...) -> console.debug(o...)



class MessageStream
  constructor: (@url) ->

  connect: () =>
    d 'connecting'
    @socket = new WebSocket(@url)
    @socket.onmessage = @receive_message
    @socket.onopen    = @welcome
    @socket.onerror   = @handle_error
    @socket.onclose   = @handle_close

  welcome: (evt) ->
    d "Welcome!"

  handle_error: (evt) ->
    d "Error!"
    d evt

  handle_close: (evt) =>
    d "Close!"
    d evt
    setTimeout @connect, 500

  send_message: (content) ->
    console.log "sending message '#{content}'"
    $.ajax
      url: '/c/general.json'
      type: 'put'
      data: {
        to: '#general'
        from: $('#nick').val()
        content: content
      }

  receive_message: (message) ->
    $("#channel").append message_template($.parseJSON(message.data))

$ ->
  message_stream = new MessageStream('ws://127.0.0.1:4567/chat/c/general.json')
  message_stream.connect()

  $('#input').on 'keypress', (e) ->
    if e.which is 13
      message_stream.send_message $(this).val()
      $(this).val('')


