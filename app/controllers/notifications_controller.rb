class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :incomplete_info_user!

  def index
    @notices = Notification.where(user: current_user)
    @notices.update_all(seen: true)

    @conversations = Conversation.where('user_one_id = ? OR user_two_id = ?', current_user.id, current_user.id)
    for conversation in @conversations
      conversation.conversation_replies.where.not(user: current_user).update_all notify: true
    end
  end

  def resources
    if params[:user_id].to_i != current_user.id
      Notification.where(user_id: params[:user_id], sender: current_user, notification_type: :resource, seen: false, resource_id: params[:resource_id]).create
    end

    render json: { success: true, status: 200 }
  end

  def delete
    Notification.where(id: params[:notification_id]).destroy_all
    render json: { success: true, status: 200 }
  end
end
