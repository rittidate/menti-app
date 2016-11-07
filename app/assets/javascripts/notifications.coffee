$(document).on 'turbolinks:load', ->

  $('.payment_accept').on 'click', () ->
    id = $(this).attr('ref')
    notice = $(this).attr('noticification')
    $.accept_session(id, notice)

  $('.payment_decline').on 'click', () ->
    id = $(this).attr('ref')
    notice = $(this).attr('noticification')
    $.decline_session(id, notice)

  $('.trash').on 'click', () ->
    id = $(this).attr('ref')
    $.delete_notification(id)

  $.accept_session = (transaction_id, notice) ->
    $.ajax(
      method: "PUT"
      url: "/payment/accept"
      data: { 
              transaction: transaction_id
              noticification: notice
            }
    ).always((d) ->
      location.reload()
    )

  $.decline_session = (transaction_id, notice) ->
    $.ajax(
      method: "PUT"
      url: "/payment/decline"
      data: { 
              transaction: transaction_id
              noticification: notice
            }
    ).always((d) ->
      location.reload()
    )

  $.delete_notification = (notification_id) ->
    $.ajax(
      method: "PUT"
      url: "/notifications/delete"
      data: { 
        notification_id: notification_id
      }
    ).always((d) ->
      if d.status == 200
        $(".notification-box[ref= " + notification_id + "]").remove()
    )