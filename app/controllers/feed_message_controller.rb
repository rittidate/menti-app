class FeedMessageController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create, :update]
  
  def create
    msg = FeedMessage.create(message_params) do |f|
      f.sender = current_user
    end
    
    if msg.reciever == current_user
      render json: { status: 200, msg: { id: msg.id, message: msg.message, time: msg.created_at.strftime("%I:%M %p"), user: 'self', avatar: msg.sender.avatar.url(:thumb) } }
    else
      render json: { status: 200, msg: { id: msg.id, message: msg.message, time: msg.created_at.strftime("%I:%M %p"), user: 'other', avatar: msg.sender.avatar.url(:thumb) } }
    end
  end

  def update
    user_ids = feed_message_user
    feed_messages = FeedMessage.where(sender_id: user_ids).where('id > ?', params[:lasted_feed]).order("created_at DESC")

    if feed_messages.count > 0
      array = Array.new
      for msg in feed_messages
        hash = { id: msg.id, message: msg.message, image: msg.image.url(:thumb), time: msg.created_at.strftime("%I:%M %p"), user: 'other', avatar: msg.sender.avatar.url(:thumb) } 
        array << hash
      end
      render json: { success: true, status: 200, msg: array }
    else
      render json: { success: false, status: 300, msg: 'No Record!!!' }
    end
  end

  def upload
    msg = FeedMessage.create(image_params) do |f|
      f.sender = current_user
    end
    redirect_to request.referer
  end

  protected
  def message_params
    params.require(:feed_message).permit(:reciever_id, :message)
  end

  def image_params
    params.require(:feed_message).permit(:image)
  end

  def feed_message_user
    user_array = Array.new
    followers = Follow.where(user_id: params[:user_id])
    for f in followers
      user_array << f.follower.id
    end
  end
end
