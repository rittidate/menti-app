$(document).on 'turbolinks:load', -> 
  $('select.select-setting').material_select();
  $('select.select-areas').material_select();
  Materialize.updateTextFields();

  $("#mentor-category-area").val()

  $.hide_and_show_category = () ->
    $('.mentor-categories-group').addClass('hide')

    categories =  $('#mentor-category-area').val()
    $.each(categories, (index, value) -> 
      $('.mentor-categories-group[ref=' + value + ']').removeClass('hide')
    )

  $.hide_and_show_category()

  $('#mentor-category-area').on 'change', () ->
    $('.mentor-categories-group').each () ->
      if $(this).hasClass('hide')
        console.log $.inArray( $(this).attr('ref'), $(this).val())
    
    $.hide_and_show_category()
