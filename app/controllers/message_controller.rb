class MessageController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = Conversation.where('user_one_id = ? OR user_two_id = ?', current_user.id, current_user.id)
  end

  def show
    @user = User.friendly.find(params[:id])
    @conversation = Conversation.where('(user_one_id = ? and user_two_id = ?) OR (user_one_id = ? and user_two_id = ?)', @user.id, current_user.id, current_user.id, @user.id).first
  end

  def create
    msg = ConversationReply.create(conversation_message_params) do |f|
      f.user = current_user
      f.seen = false
    end

    render json: { status: 200, msg: { message: msg.reply, time: msg.created_at.strftime("%I:%M %p"), user: 'self', avatar: msg.user.avatar.url(:thumb) } }
  end

  protected
  def conversation_message_params
    params.require(:conversation).permit(:conversation_id, :reply)
  end
end
