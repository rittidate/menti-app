class DashboardController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  
  def index
  end
end
