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

    render json: { status: 200, msg: { id: msg.id, message: msg.reply, time: msg.created_at.strftime("%I:%M %p"), user: 'self', avatar: msg.user.avatar.url(:thumb) } }
  end

  def update
    replies = ConversationReply.where(conversation_id: params['conversation_id']).where('id > ?', params['lasted_reply']).where.not(user: current_user)
    if replies.count > 0
      array = Array.new
      i = 0
      for reply in replies
        hash = { id: reply.id, message: reply.reply, time: reply.created_at.strftime("%I:%M %p"), user: 'other', avatar: reply.user.avatar.url(:thumb) } 
        array[i] = hash
        i += 1
      end
      render json: { success: true, status: 200, msg: array }
    else
      render json: { success: false, status: 300, msg: 'No Record!!!' }
    end
    
  end

  protected
  def conversation_message_params
    params.require(:conversation).permit(:conversation_id, :reply)
  end
end
