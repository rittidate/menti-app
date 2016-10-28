$(document).on 'turbolinks:load', ->  
  $('.datepicker').pickadate
    selectMonths: true, 
    selectYears: 80
    format: 'mm/dd/yyyy'
    max: 10

  $('input.autocomplete').autocomplete({
    data: {
      "Australia": null,
      "India": null,
      "Thailand": null
    }
  });

  Materialize.updateTextFields();
  $('select.security_question_select').material_select();
