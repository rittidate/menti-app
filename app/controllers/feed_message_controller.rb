class FeedMessageController < ApplicationController
  def create
    msg = FeedMessage.create(message_params) do |f|
      f.sender = current_user
    end
    
    if msg.reciever == current_user
      render json: { status: 200, msg: { message: msg.message, time: msg.created_at.strftime("%I:%M %p"), user: 'self', avatar: msg.sender.avatar.url(:thumb) } }
    else
      render json: { status: 200, msg: { message: msg.message, time: msg.created_at.strftime("%I:%M %p"), user: 'other', avatar: msg.sender.avatar.url(:thumb) } }
    end
  end

  protected
  def message_params
    params.require(:feed_message).permit(:reciever_id, :message)
  end
end
