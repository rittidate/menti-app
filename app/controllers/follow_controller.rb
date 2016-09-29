class FollowController < ApplicationController
  before_action :authenticate_user!
  
  def create
    current_user.follows.where(follower_id: params['follow_user']).first_or_create!
    render json: { success: true, status: 200 }
  end

  def delete
    current_user.follows.where(follower_id: params['follow_user']).destroy_all
    render json: { success: true, status: 200 }
  end
end
