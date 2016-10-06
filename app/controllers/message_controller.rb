class MessageController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = Conversation.where('user_one_id = ? OR user_two_id = ?', current_user.id, current_user.id)
  end

  def show
    @user = User.friendly.find(params[:id])
    @conversations = Conversation.where('user_one_id = ? OR user_two_id = ?', current_user.id, current_user.id)
    @conversation = Conversation.where('(user_one_id = ? and user_two_id = ?) OR (user_one_id = ? and user_two_id = ?)', @user.id, current_user.id, current_user.id, @user.id).first
    
    @conversation.conversation_replies.where.not(user: current_user).update_all seen: true

    @notification = Notification.where(conversation_id: @conversation.id, user: current_user, seen: false).update_all seen: true
  end

  def create
    msg = ConversationReply.create(conversation_message_params) do |f|
      f.user = current_user
      f.seen = false
    end

    render json: { status: 200, msg: { id: msg.id, message: msg.reply, time: msg.created_at.strftime("%I:%M %p"), user: 'self', avatar: msg.user.avatar.url(:thumb) } }
  end

  def update
    message_notification
    replies = ConversationReply.where(conversation_id: params['conversation_id']).where('id > ?', params['lasted_reply']).where.not(user: current_user)
    replies.update_all seen: true

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

  def unread_message?
    ConversationReply.where(conversation_id: params['conversation_id'], user: current_user, seen: false).where('created_at < ?', 15.seconds.ago).present?
  end

  def message_notification
    if unread_message?
      @conversation = Conversation.find(params['conversation_id'])
      if @conversation.user_one == current_user
        receiver_user = @conversation.user_two
      else
        receiver_user = @conversation.user_one
      end
      Notification.where(user_id: receiver_user, sender: current_user, notification_type: :message, seen: false, conversation_id: params['conversation_id']).first_or_create
    end
  end
end
