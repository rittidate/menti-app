$(document).on 'turbolinks:load', ->
  $('.collapsible').collapsible({
    accordion : false
  });

  $('#js-conversation-send-message').on "click", ->
    text = $('#js-conversation-message').val()
    if text != ''
      $.create_conversation_message(text)
      $('#js-conversation-message').val('')

  $.create_conversation_message = (message) ->
    $.ajax(
      method: "POST"
      url: "/message"
      data: { 
              conversation:
                conversation_id: $('#coversation').val()
                reply: message
            }
    ).always( (data) ->
      if data.status == 200
        $('ol.chat-msg').append($.coversation_element(data.msg))
    )

  $.coversation_element = (msg) ->
    default_url = $('#default-img').attr('src')
    if msg.avatar == 'images/thumb/avatar.png'
      avatar =  $('<div />', {'class': 'avatar-msg'}).append($('<img/>', {'src': default_url, 'draggable': 'false'}))
    else
      avatar =  $('<div />', {'class': 'avatar-msg'}).append($('<img/>', {'src': msg.avatar, 'draggable': 'false'}))
    text = $('<div />', {'class': 'msg-msg'}).append($('<p/>', {text: msg.message})).append($('<time/>', {text: msg.time}))
    $('<li />', { 'class': 'self-msg'}).append(avatar).append(text)