class MessageController < ApplicationController
  before_action :authenticate_user!
end
