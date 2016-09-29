class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  def authenticate_user!
    unless current_user
      session[:from] = request.original_fullpath
      respond_to do |format|
        format.html { redirect_to user_session_path }
        format.json { deny_json_access }
      end
    end
  end

  def generate_client_token
    Braintree::ClientToken.generate
  end
end
