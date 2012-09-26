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


send_message = (content) ->
  console.log "sending message '#{content}'"
  $.ajax
    url: '/c/general.json'
    type: 'put'
    data: {
      to: '#general'
      from: $('#nick').val()
      content: content
    }


receive_message = (message) ->
  $("#channel").append message_template($.parseJSON(message.data))

$ ->
  $('#input').on 'keypress', (e) ->
    if e.which is 13
      send_message $(this).val()
      $(this).val('')

  socket = new WebSocket('ws://127.0.0.1:4567/chat/c/general.json')
  socket.onmessage = receive_message
