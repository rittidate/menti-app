$(document).on 'turbolinks:load', -> 
  
  return if $('#js-form-category').length != 1
  $('.category_checkbox').each ->
    attr = $(this).attr('ref')
    if $(this).prop( "checked" )
      $('.sub_category[ref=' + attr + ']').show()
    else
      $('.sub_category[ref=' + attr + ']').hide()
  .on "click", ->
    attr = $(this).attr('ref')
    if $(this).prop( "checked" )
      $('.sub_category[ref=' + attr + ']').show()
    else
      $('.sub_category[ref=' + attr + ']').hide()

  $(".sub_category_checkbox").on "click", ->
    id = $(this).attr('ref')
    if $(this).prop( "checked" )
      $.create_category_user_relation(id)
      $('.sub_category[ref=' + id + ']').show()
    else
      $.delete_category_user_relation(id)
      
  $(".current_level_range").on "input", ->
    id = $(this).attr('ref')
    $('.current_badge[ref=' + id + ']').text this.value
  .on "change", ->
    id = $(this).attr('ref')
    if $('.sub_category_checkbox[ref='+id+']').prop( "checked" )
      $.update_current_value(id, this.value) 

  $(".desired_level_range").on "input", ->
    id = $(this).attr('ref')
    $('.desired_badge[ref=' + id + ']').text this.value
  .on "change", ->
    id = $(this).attr('ref')
    if $('.sub_category_checkbox[ref='+id+']').prop( "checked" )
      $.update_desire_value(id, this.value) 

  $.create_category_user_relation = (catergory_id) ->
    $.ajax(
      method: "PUT"
      url: "/category/create_relation"
      data: { 
              catergory_id: catergory_id
            }
    )

  $.delete_category_user_relation = (catergory_id) ->
    $.ajax(
      method: "PUT"
      url: "/category/delete_relation"
      data: { 
              catergory_id: catergory_id
            }
    ).always( (data) ->
      $('.current_badge[ref=' + catergory_id + ']').text 0
      $('.desired_badge[ref=' + catergory_id + ']').text 0
      $('.current_level_range[ref=' + catergory_id + ']').val(0)
      $('.desired_level_range[ref=' + catergory_id + ']').val(0)
    )

  $.update_current_value = (catergory_id, value) ->
    $.ajax(
      method: "PUT"
      url: "/category/update_current"
      data: { 
              catergory_id: catergory_id
              value: value
            }
    )

  $.update_desire_value = (catergory_id, value) ->
    $.ajax(
      method: "PUT"
      url: "/category/update_desire"
      data: { 
              catergory_id: catergory_id
              value: value
            }
    )