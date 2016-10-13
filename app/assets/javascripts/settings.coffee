$(document).on 'turbolinks:load', -> 
  $('select.select-setting').material_select();
  $('select.select-areas').material_select();
  Materialize.updateTextFields();
