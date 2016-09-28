$(document).on 'turbolinks:load', ->
  $.validate()

  $('.button-collapse').sideNav({
    menuWidth: 300, 
    edge: 'right', 
    closeOnClick: true 
    }
  )
