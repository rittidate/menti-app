class NotificationsController < ApplicationController
  def index
    @notices = Notification.where(user: current_user)
  end
end
