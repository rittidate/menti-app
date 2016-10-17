$(document).on 'turbolinks:load', ->
  $('.collapsible').collapsible({
    accordion : false
  })
  $('.tooltipped').tooltip({});

  $.coversation_element = (msg) ->
    default_url = $('#default-img').attr('src')
    if msg.avatar == 'images/thumb/avatar.png'
      avatar =  $('<div />', {'class': 'avatar-msg'}).append($('<img/>', {'src': default_url, 'draggable': 'false'}))
    else
      avatar =  $('<div />', {'class': 'avatar-msg'}).append($('<img/>', {'src': msg.avatar, 'draggable': 'false'}))
    text = $('<div />', {'class': 'msg-msg'}).append($('<p/>', {text: msg.message})).append($('<time/>', {text: msg.time}))
    $('<li />', { 'class': 'self-msg'}).append(avatar).append(text)

  $.coversation_other_element = (msg) ->
    $('#lasted_reply').val(msg.id)
    default_url = $('#default-img').attr('src')
    if msg.avatar == 'images/thumb/avatar.png'
      avatar =  $('<div />', {'class': 'avatar-msg'}).append($('<img/>', {'src': default_url, 'draggable': 'false'}))
    else
      avatar =  $('<div />', {'class': 'avatar-msg'}).append($('<img/>', {'src': msg.avatar, 'draggable': 'false'}))

    if msg.message != null
      text = $('<div />', {'class': 'msg-msg'}).append($('<p/>', {text: msg.message})).append($('<time/>', {text: msg.time}))
    else
      image = $('<p/>').append($('<img/>', {'src': msg.image, 'draggable': 'false'}))
      text = $('<div />', {'class': 'msg-msg'}).append(image).append($('<time/>', {text: msg.time}))

    $('<li />', { 'class': 'other-msg'}).append(avatar).append(text)

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
        $('#lasted_reply').val(data.msg.id)
        $('ol.chat-msg').prepend($.coversation_element(data.msg))
    )

  $.update_conversation = () ->
    $.ajax(
      method: "PUT"
      url: "/message/update"
      async: false
      data: { 
              conversation_id: $('#coversation').val()
              lasted_reply: $('#lasted_reply').val()
            }
    ).success( (data) ->
      if data.status == 200
        messages = data.msg
        for itemIndex in [0...messages.length]
          $('ol.chat-msg').prepend($.coversation_other_element(messages[itemIndex]))
      window.setTimeout($.update_conversation, 10000);
    )

  return if $('#js-conversation-send-message').length != 1
  $.update_conversation()

  $('#js-conversation-send-message').on "click", ->
    text = $('#js-conversation-message').val()
    if text != ''
      $.create_conversation_message(text)
      $('#js-conversation-message').val('')

  $('#message-attach-button').on "click", ->
    $("input[type='file']").trigger('click')

  $('.reply_message_upload').on "change", ->
    $('.message-attach-form').submit()




