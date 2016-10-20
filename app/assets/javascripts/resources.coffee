$(document).on 'turbolinks:load', ->  
  $('#resource-upload-button').on 'click', () ->
    $("input[type='file']").trigger('click')

  $('.resource-attach-form').on 'change', () ->
    filename = $('input[type=file]').val().split('\\').pop()
    $('#resource_resource_name').val(filename)
    $('.resource-attach-form').submit()
    