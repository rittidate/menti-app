class BraintreeApi
  class BraintreeApi::NilNonceException < StandardError ; end
  class BraintreeApi::CreditCardVerifyException < StandardError ; end
  def add_card(nonce, user, is_default, is_public = true, bill_address)
    raise NilNonceException, 'nonce is nil' unless nonce

    result = Braintree::Customer.create(
      first_name: user.first_name,
      last_name: user.last_name,
      credit_card: {
        payment_method_nonce: nonce,
        options: {
          verify_card: true
        }
      }
    )

    if result.success?
      credit_card = result.customer.try(:credit_cards).first
      payment = user.payments.where(token: credit_card.token, customer_id: result.customer.id, is_public: is_public).first_or_create!
      payment.update!(
        card_type: credit_card.try(:card_type),
        masked_number: 'xxxx xxxx xxxx ' + credit_card.try(:last_4)
      )
      user.update!(default_payment: payment) if is_default == 'true'
      add_bill_address(result.customer.id, user, bill_address)
      return payment
    else
      result.errors.each do |error|
        raise CreditCardVerifyException
      end

      verification = result.credit_card_verification
      if verification.status == 'gateway_rejected'
        # TODO log verification.gateway_rejection_reason
      else
        # TODO log verification.processor_response_text
      end

      raise CreditCardVerifyException
    end

  end

  def add_bill_address(customer_id, user, bill_address)
    result = Braintree::Address.create(
      customer_id: customer_id,
      first_name: user.first_name,
      last_name: user.last_name,
      company: bill_address['company'],
      street_address: bill_address['address'],
      extended_address: bill_address['extended_address'],
      locality: bill_address['city'],
      region: bill_address['state'],
      postal_code: bill_address['postalCode'],
      country_code_alpha2: bill_address['country']
    )
  end
end
