$(document).on 'turbolinks:load', ->
  
  return if $('#js-payment-client-token').length != 1
  client_token = $('#js-payment-client-token').val()
  client = new braintree.api.Client({clientToken: client_token})
  auto_validate = false
  security_length = 3
  $('#js-payment-country').material_select();
  
  $('#js-payment-submit').on 'click', ->
    $.form_payment_submit()

  $.form_payment_submit = ->
    unless $.basic_validate_credit_card()
      $('body')[0].scrollTop = $('.payment-form .invalid').get(0).offsetTop
      return
    client.tokenizeCard(
      number: $('#js-payment-cardnumber').val()
      expirationDate: $('#js-payment-expiration').val()
      cardholderName: $('#js-payment-name').val()
      cvv: $('#js-payment-security-code').val()
      postalCode: $('#js-payment-zip').val()
    , (err, nounce) ->
      if err
        console.log 'card error'
      else
        $.save_credit_card(nounce)
    )

  $.save_credit_card = (nounce) ->
    $.ajax(
      method: "POST"
      url: "/payment.json"
      data: { 
              payment_method_nonce: nounce
              is_default: $('#js-default-payment').prop('checked')
              bill_address:
                company: $('#js-payment-company').val()
                address: $('#js-payment-address').val()
                extended_address: $('#js-payment-apt').val()
                city: $('#js-payment-city').val()
                state: $('#js-payment-state').val()
                country: $('#js-payment-country').val()
                postalCode: $('#js-payment-zip').val()
            }
    ).always( (data) ->
      if(data.status == 200)
        window.location.assign($('.prev-page').attr('href'))
      else
        Materialize.toast(data.responseText, 5000)
    );

  $.basic_validate_credit_card = ->
    auto_validate = true
    is_all_valid = true
    is_all_valid &= validate_payment_placeholder()
    is_all_valid &= validate_payment_cardnumber()
    is_all_valid &= validate_payment_expiration()
    is_all_valid &= validate_payment_security_code()
    is_all_valid &= validate_payment_postal_code()

  $.payment_listener =
    name: ->
      return unless auto_validate 
      validate_payment_placeholder()
    cardnumber: ->
      validate_payment_cardnumber()
    expiration: ->
      return unless auto_validate
      validate_payment_expiration()
    securitycode: ->
      return unless auto_validate
      validate_payment_security_code()
    zip: ->
      return unless auto_validate
      validate_payment_postal_code()
    clear_validate: ->
      auto_validate = false

  validator_input_manager = (elem, isValid, onSuccess) ->
    if isValid
      elem.removeClass('invalid')
      elem.addClass('valid')
      onSuccess() if typeof onSuccess == 'function'
    else
      elem.removeClass('valid')
      elem.addClass('invalid')

  validate_payment_placeholder = ->
    isValid = $('#js-payment-name').val().length > 5
    validator_input_manager($('#js-payment-name'), isValid)
    return isValid

  validate_payment_cardnumber = ->
    validate_obj = cardValidator.number($('#js-payment-cardnumber').val())
    if auto_validate
      validator_input_manager($('#js-payment-cardnumber'), validate_obj.isValid, -> 
        update_card_type validate_obj.card
      )
    else if validate_obj.isValid
      update_card_type validate_obj.card
    return validate_obj.isValid

  validate_payment_expiration = ->
    validate_obj = cardValidator.expirationDate($('#js-payment-expiration').val())
    validator_input_manager($('#js-payment-expiration'), validate_obj.isValid)
    return validate_obj.isValid

  validate_payment_security_code = ->
    validate_obj = cardValidator.cvv($('#js-payment-security-code').val(), security_length)
    validator_input_manager($('#js-payment-security-code'), validate_obj.isValid)
    return validate_obj.isValid

  validate_payment_postal_code = ->
    validate_obj = cardValidator.postalCode($('#js-payment-zip').val())
    validator_input_manager($('#js-payment-zip'), validate_obj.isValid)
    return validate_obj.isValid

  update_card_type = (card_pattern) ->
    $('#js-payment-tag-security-code').html(card_pattern.code.name)
    $('#js-payment-security-code').attr('maxlength', card_pattern.code.size)
    security_length = card_pattern.code.size
    validate_payment_security_code if auto_validate