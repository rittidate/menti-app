module PaymentHelper
  def payment_logo(type)
    if type === 'Visa'
      'payment_icon/visa.png'
    elsif type === 'MasterCard'
      'payment_icon/mastercard.png'
    elsif type === 'American Express'
      'payment_icon/american_express.png'
    end
  end
end
