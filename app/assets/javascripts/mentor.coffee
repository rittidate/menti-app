$(document).on 'turbolinks:load', ->
  
  $('.mentor_category_checkbox').each () ->
    id = $(this).attr('ref')
    if $(this).prop('checked')
      $('.mentor_category_price[ref=' + id + ']').prop('disabled', false)
      $('.mentor_category_price_div[ref=' + id + ']').show()
    else
      $('.mentor_category_price[ref=' + id + ']').prop('disabled', true)
      $('.mentor_category_price_div[ref=' + id + ']').hide()
  .on 'click',  () ->
    id = $(this).attr('ref')
    if $(this).prop( "checked" )
      $('.mentor_category_price_div[ref=' + id + ']').show()
      $('.mentor_category_price[ref=' + id + ']').prop('disabled', false)
    else
      $('.mentor_category_price_div[ref=' + id + ']').hide()
      $('.mentor_category_price[ref=' + id + ']').prop('disabled', true)