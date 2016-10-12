$(document).on 'turbolinks:load', ->

  $.chat_element = (msg) ->
    $('#js-newest-message').val(msg.id)
    default_url = $('#default-img').attr('src')
    if msg.avatar == 'images/thumb/avatar.png'
      avatar =  $('<div />', {'class': 'avatar'}).append($('<img/>', {'src': default_url}))
    else
      avatar =  $('<div />', {'class': 'avatar'}).append($('<img/>', {'src': msg.avatar}))
    text = $('<div />', {'class': 'msg'}).append($('<p/>', {text: msg.message})).append($('<time/>', {text: msg.time}))
    $('<li />', { 'class': msg.user}).append(avatar).append(text)

  $.update_feed_message = () ->
    $.ajax(
      method: "PUT"
      url: "/feed_message/update"
      async: false
      data: { 
              user_id: $('#js-feed-reciever').val()
              lasted_feed: $('#js-newest-message').val()
            }
    ).success( (data) ->
      if data.status == 200
        messages = data.msg
        for itemIndex in [0...messages.length]
          $('ol.chat').prepend($.chat_element(messages[itemIndex]))
      window.setTimeout($.update_feed_message, 5000);
    )
  
  return if $('#js-feed-container').length != 1
  $.update_feed_message()
  $('#js-feed-message-button').on "click", ->
    text = $('#feed-message-area').val()
    if text != ''
      $.create_feed_message(text)
      $('#feed-message-area').val('')
      

  $.create_feed_message = (message) ->
    $.ajax(
      method: "PUT"
      url: "/feed_message"
      data: { 
              feed_message:
                reciever_id: $('#js-feed-reciever').val()
                message: message
            }
    ).always( (data) ->
      if data.status == 200
        $('.js-no-content').hide()
        $('#js-newest-message').val(data.msg.id)
        $('ol.chat').prepend($.chat_element(data.msg))
    )

