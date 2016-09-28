class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to dashboard_path
    else
      render layout: 'home_application'
    end
  end

  def terms
  end
end
