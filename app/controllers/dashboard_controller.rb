class DashboardController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  
  def index
    user_ids = feed_message_user
    @feed_message = FeedMessage.where(sender_id: user_ids).order("created_at DESC")
  end
private
  def feed_message_user
    user_array = Array.new
    for f in current_user.follows
      user_array << f.follower.id
    end

    user_array << current_user.id
  end
end
