$(document).on 'turbolinks:load', -> 
  $("#js-follow-button").on 'click', () ->
    if $(this).hasClass('follow')
      $(this).addClass('unfollow').removeClass('follow')
      $(this).text('Unfollow')
      $.follow_user()
    else if $(this).hasClass('unfollow')
      $(this).addClass('follow').removeClass('unfollow')
      $(this).text('Follow')
      $.unfollow_user()

  $.follow_user = () ->
    $.ajax(
      method: "PUT"
      url: "/follow"
      data: { 
              follow_user: $('#js-feed-reciever').val()
            }
    )

  $.unfollow_user = () ->
    $.ajax(
      method: "PUT"
      url: "/follow/delete"
      data: { 
              follow_user: $('#js-feed-reciever').val()
            }
    )