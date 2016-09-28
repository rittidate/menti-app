$(document).on 'turbolinks:load', -> 
  $('select.select-setting').material_select();
  Materialize.updateTextFields();
