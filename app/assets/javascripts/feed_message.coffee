$(document).on 'turbolinks:load', ->
  
  return if $('#js-feed-container').length != 1
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
        $('ol.chat').prepend($.chat_element(data.msg))
    )

  $.chat_element = (msg) ->
    default_url = $('#default-img').attr('src')
    if msg.avatar == 'images/thumb/avatar.png'
      avatar =  $('<div />', {'class': 'avatar'}).append($('<img/>', {'src': default_url}))
    else
      avatar =  $('<div />', {'class': 'avatar'}).append($('<img/>', {'src': msg.avatar}))
    text = $('<div />', {'class': 'msg'}).append($('<p/>', {text: msg.message})).append($('<time/>', {text: msg.time}))
    $('<li />', { 'class': msg.user}).append(avatar).append(text)# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
