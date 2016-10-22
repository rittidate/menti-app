$(document).on 'turbolinks:load', ->  
  $('#resource-upload-button').on 'click', () ->
    $("input[type='file']").trigger('click')

  $('.resource-attach-form').on 'change', () ->
    filename = $('input[type=file]').val().split('\\').pop()
    $('#resource_resource_name').val(filename)
    $('.resource-attach-form').submit()

  $('.resource-access').on 'click', (e) ->
    e.preventDefault();
    url = $(this).attr('href')
    user = $(this).attr('user')
    resource = $(this).attr('resource')
    $.ajax(
      method: "POST"
      url: "/notifications/resources"
      async: false
      data: { 
              user_id: user
              resource_id: resource
            }
    ).success( (data) ->
      if data.status == 200
        window.open(url, '_blank');
    )


    