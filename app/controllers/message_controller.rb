class MessageController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = Conversation.where('user_one_id = ? OR user_two_id = ?', current_user.id, current_user.id)
  end
  def show
    @user = User.friendly.find(params[:id])
  end
end
