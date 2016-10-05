class MessageController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = Conversation.where('user_one_id = ? OR user_two_id = ?', current_user.id, current_user.id)
  end
  def show
    @user = User.friendly.find(params[:id])
    @conversation = Conversation.where('(user_one_id = ? and user_two_id = ?) OR (user_one_id = ? and user_two_id = ?)', @user.id, current_user.id, current_user.id, @user.id).first
  end
end
