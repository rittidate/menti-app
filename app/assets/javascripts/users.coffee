$(document).on 'turbolinks:load', -> 
  $('#submit-course').addClass('disabled')
                    .on 'click', () ->
                      if $(this).hasClass('disabled')
                        $("form").submit (e) ->
                            e.preventDefault();
                      else
                        $("form").submit()
                        

  $('#option').on 'click', () ->
    $('#submit-course').removeClass('disabled')

  $('#option2').on 'click', () ->
    $('#submit-course').addClass('disabled')