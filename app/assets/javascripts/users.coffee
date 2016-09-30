$(document).on 'turbolinks:load', -> 
  $.rating_star = (num) ->
    switch num
      when '1' 
        $('.rating-star[num=1]').addClass('active')
        $('.rating-star[num=2]').removeClass('active')
        $('.rating-star[num=3]').removeClass('active')
        $('.rating-star[num=4]').removeClass('active')
        $('.rating-star[num=5]').removeClass('active')
      when '2'
        $('.rating-star[num=1]').addClass('active')
        $('.rating-star[num=2]').addClass('active')
        $('.rating-star[num=3]').removeClass('active')
        $('.rating-star[num=4]').removeClass('active')
        $('.rating-star[num=5]').removeClass('active')
      when '3'
        $('.rating-star[num=1]').addClass('active')
        $('.rating-star[num=2]').addClass('active')
        $('.rating-star[num=3]').addClass('active')
        $('.rating-star[num=4]').removeClass('active')
        $('.rating-star[num=5]').removeClass('active')
      when '4'
        $('.rating-star[num=1]').addClass('active')
        $('.rating-star[num=2]').addClass('active')
        $('.rating-star[num=3]').addClass('active')
        $('.rating-star[num=4]').addClass('active')
        $('.rating-star[num=5]').removeClass('active')
      when '5'
        $('.rating-star[num=1]').addClass('active')
        $('.rating-star[num=2]').addClass('active')
        $('.rating-star[num=3]').addClass('active')
        $('.rating-star[num=4]').addClass('active')
        $('.rating-star[num=5]').addClass('active')
      else
        $('.rating-star[num=1]').removeClass('active')
        $('.rating-star[num=2]').removeClass('active')
        $('.rating-star[num=3]').removeClass('active')
        $('.rating-star[num=4]').removeClass('active')
        $('.rating-star[num=5]').removeClass('active')

  $.rating_star($('#rating_value').val())

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

  $('.rating-star').hover () ->
    num = $(this).attr('num')
    $.rating_star(num)
  , () -> 
    $.rating_star $('#rating_value').val()

  $('.rating-give').on 'click', () ->
    num = $(this).attr('num')
    $.give_rating(num)

  $.give_rating = (num) ->
    $.ajax(
      method: "POST"
      url: "/rating"
      data: { 
              user: $('#js-feed-reciever').val()
              courses_user_relations: $('#courses_user_relations').val()
              value: num
            }
    ).always( (d) ->
      $('#rating_value').val(d.value)
    )


