$(document).on 'turbolinks:load', ->

  $.chat_element = (msg) ->
    $('#js-newest-message').val(msg.id)
    default_url = $('#default-img').attr('src')
    if msg.avatar == 'images/thumb/avatar.png'
      avatar =  $('<div />', {'class': 'avatar'}).append($('<img/>', {'src': default_url}))
    else
      avatar =  $('<div />', {'class': 'avatar'}).append($('<img/>', {'src': msg.avatar}))

    if msg.message != null
      if msg.cr != null
        cr = $('<p/>', {text: 'Cr.'}).append($('<a/>', { href: msg.cr_url, text: msg.cr }))
        text = $('<div />', {'class': 'msg'}).append($('<h5/>', {class: 'msg-name', text: msg.first_name})).append($('<p/>', {text: msg.message})).append(cr).append($('<time/>', {text: msg.time}))
      else
        text = $('<div />', {'class': 'msg'}).append($('<h5/>', {class: 'msg-name', text: msg.first_name})).append($('<p/>', {text: msg.message})).append($('<time/>', {text: msg.time}))
    else
      if msg.cr != null
        cr = $('<p/>', {text: 'Cr.'}).append($('<a/>', { href: msg.cr_url, text: msg.cr }))
        image = $('<p/>').append($('<img/>', {'src': msg.image, 'draggable': 'false'}))
        text = $('<div />', {'class': 'msg'}).append($('<h5/>', {class: 'msg-name', text: msg.first_name})).append(image).append(cr).append($('<time/>', {text: msg.time}))
      else
        image = $('<p/>').append($('<img/>', {'src': msg.image, 'draggable': 'false'}))
        text = $('<div />', {'class': 'msg'}).append($('<h5/>', {class: 'msg-name', text: msg.first_name})).append(image).append($('<time/>', {text: msg.time}))

    


    $('<li />', { 'class': msg.user}).append(avatar).append(text)

  $.update_feed_message = () ->
    $.ajax(
      method: "PUT"
      url: "/feed_message/update"
      async: false
      data: { 
              user_id: $('#js-feed-sender').val()
              lasted_feed: $('#js-newest-message').val()
            }
    ).success( (data) ->
      if data.status == 200
        messages = data.msg
        for itemIndex in [0...messages.length]
          $('ol.chat').prepend($.chat_element(messages[itemIndex]))
      window.setTimeout($.update_feed_message, 36000)
    )
  
  $('.js-share-feed').on "click", ->
    id = $(this).attr('ref')
    $.ajax(
      method: "PUT"
      url: "/feed_message/share"
      async: false
      data: { 
              feed_id: id
            }
    ).success( (data) ->
      current_user = $('#js-feed-current-user').val()
      reciever_id = $('#js-feed-reciever').val()
      if data.status == 200
        Materialize.toast("Shared!!!", 5000)
        if current_user == reciever_id
          $('#js-newest-message').val(data.msg.id)
          $('ol.chat').prepend($.chat_element(data.msg))
    )

  return if $('#js-feed-container').length != 1
  window.setTimeout($.update_feed_message, 36000)
  $('#js-feed-message-button').on "click", ->
    text = $('#feed-message-area').val()
    if text != ''
      $.create_feed_message(text)
      $('#feed-message-area').val('')

  $('.feed-attach').on "click", ->
    $("input[type='file']").trigger('click')

  $('.feed_message_upload').on "change", ->
    $('.feed-attach-form').submit()

  $('#feed-message-area').on "keydown", (e) ->
    text = $('#feed-message-area').val()
    if e.ctrlKey && e.keyCode == 13 && text != ''
      $("#js-feed-message-button").trigger('click')

  $.create_feed_message = (message) ->
    $.ajax(
      method: "PUT"
      url: "/feed_message"
      data: { 
              feed_message:
                message: message
            }
    ).always( (data) ->
      if data.status == 200
        $('.js-no-content').hide()
        $('#js-newest-message').val(data.msg.id)
        $('ol.chat').prepend($.chat_element(data.msg))
    )

