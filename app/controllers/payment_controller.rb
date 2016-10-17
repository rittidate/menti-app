class PaymentController < ApplicationController
  before_action :authenticate_user!
  before_action :incomplete_info_user!
  
  def new
    @client_token = generate_client_token
  end

  def create
    nonce = params[:payment_method_nonce]
    bill_address = params[:bill_address]
    begin
      BraintreeApi.new.add_card(nonce, current_user, params[:is_default], bill_address)
      respond_to do |format|
        format.json do
          flash[:notice] = 'Payment card was successfully created.'
          render nothing: true
        end
      end
    rescue BraintreeApi::NilNonceException
      respond_to do |format|
        format.json do
          render nothing: true, status: :no_content
        end
      end
    rescue BraintreeApi::CreditCardVerifyException => e
      respond_to do |format|
        format.json do
          render json: "Sorry, Card Declined. Please check your card or use another card to process.", status: 422
        end
      end
    end
  end

  def destroy
    @payment = Payment.find(params[:id])
    @payment.destroy!
    flash[:notice] = 'Payment card was successfully deleted.'
    redirect_to request.referer
  end

  def set_default
    if current_user.update(payment_params)
      redirect_to request.referer
    else
      render json: { errors: { message: current_user.errors.full_messages.first }, status: 400 }
    end
  end

  def accept
    begin
      transaction = Transaction.find(params[:transaction])
      noticification = Notification.find(params[:noticification])
      transaction.user.collect_transaction(transaction, noticification)
      render json: { success: true, data: transaction, status: 200 }
    rescue BraintreeApi::NilNonceException
      #render json: { error: { type: 'payment', message: "Sorry, Card Declined. Please check your card or use another card to process this transaction." } }
      render json: "Sorry, Card Declined. Please check your card or use another card to process this transaction.", status: 422
    rescue BraintreeApi::CreditCardVerifyException
      #render json: { error: { type: 'payment', message: "Sorry, Card Declined. Please check your card or use another card to process this transaction." } }
      render json: "Sorry, Card Declined. Please check your card or use another card to process this transaction.", status: 422
    end
  end

  def decline
    begin
      transaction = Transaction.find(params[:transaction])
      noticification = Notification.find(params[:noticification])
      transaction.user.release_transaction(transaction, noticification)
      render json: { success: true, data: transaction, status: 200 }
    rescue BraintreeApi::NilNonceException
      #render json: { error: { type: 'payment', message: "Sorry, Card Declined. Please check your card or use another card to process this transaction." } }
      render json: "Sorry, Card Declined. Please check your card or use another card to process this transaction.", status: 422
    rescue BraintreeApi::CreditCardVerifyException
      #render json: { error: { type: 'payment', message: "Sorry, Card Declined. Please check your card or use another card to process this transaction." } }
      render json: "Sorry, Card Declined. Please check your card or use another card to process this transaction.", status: 422
    end
  end

  private
    def payment_params
      params.require(:user).permit(:default_payment_id)
    end
  
end
