$(document).on 'turbolinks:load', ->  
  $('.button-collapse-other').sideNav()
  $('.modal-trigger').leanModal()
  jQuery ->
      $(".close").click (event)->
    
        #like this
        event.preventDefault()
  $('.modal-contact-trigger').leanModal({
  dismissible: false
  opacity: .5
  in_duration: 300
  out_duration: 200
  starting_top: '4%'
  ending_top: '10%'
  ready: ->
    ###alert 'Ready'###
    return
  complete: ->
    ###alert 'Closed'###
    return
    });

  return if $('#modal-track').length != 1
  $('#close').on 'click', () ->
    $('#modal-track').closeModal()

  $('.progress').on 'click', () ->
    id = $(this).attr('ref')
    
    $.query_category_user_relation(id)

  $.query_category_user_relation = (catergory_id) ->
    $.ajax(
      method: "PUT"
      url: "/category/relation"
      data: { 
              catergory_id: catergory_id
              user: $('#js-feed-sender').val()
            }
    ).always((d) ->
      $.clear_right_category_content() if $(".progress-left-side") != undefined
      $('#parent_category').val(catergory_id)
      $(".progress-bar-content").append($.create_right_category_content(d.data))
      $.set_default_value(d.data[0])
      $('#modal-track').openModal()
    )

  $(".current_level_range").on "input", ->
    id = $('#current_category').val()
    $('.current_badge').text this.value
  .on "change", ->
    id = $('#current_category').val()
    $.update_current_value(id, this.value) 

  $(".desired_level_range").on "input", ->
    id = $('#current_category').val()
    $('.desired_badge').text this.value
  .on "change", ->
    id = $('#current_category').val()
    $.update_desire_value(id, this.value)

  $.create_right_category_content = (data) ->
    $div = $("<div>").addClass('progress-left-side')

    for itemIndex in [0...data.length]
      $head = $("<h6>", {text: data[itemIndex].name, class: 'center sliders'})
      $range = $("<div>").addClass('range-bar')
      $progress = $("<div>", {ref: data[itemIndex].id, class: 'progress action'})
      $determinate = $("<div>", {class: 'determinate determinate_popup', ref: data[itemIndex].id, style: "width: " + data[itemIndex].value + "%;"})

      progress = $progress.append($determinate)
                          .on "click", () ->
                            $.get_category_value $(this).attr('ref')
      range = $range.append(progress)
      $div.append($head).append(range)

  $.get_category_value = (id) ->
    $.ajax(
      method: "PUT"
      url: "/category/relation_one"
      data: { 
              category_id: id
              user: $('#js-feed-sender').val()
            }
    ).always((d) ->
      $.set_default_value(d.data)
    )


  $.clear_right_category_content = () ->
    $(".progress-left-side").remove()

  $.set_default_value = (data) ->
    $('.progress-body-header').text(data.name)
    $('#current_category').val(data.id)
    $('.current_badge').text(data.value)
    $('.desired_badge').text(data.desire_value)
    $('.current_level_range').val(data.value)
    $('.desired_level_range').val(data.desire_value)

  $.update_current_value = (catergory_id, value) ->
    $.ajax(
      method: "PUT"
      url: "/category/update_current"
      data: { 
              parent_id: $('#parent_category').val()
              catergory_id: catergory_id
              value: value
            }
    ).always((d) ->
      if d.status == 200
        $('.determinate_popup[ref=' + catergory_id + ']').width(value + '%')
        $('.determinate_base[ref=' + d.data.id + ']').width(d.data.average + '%')
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
