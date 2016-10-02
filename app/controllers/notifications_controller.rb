class NotificationsController < ApplicationController
  def index
    @notices = Notification.where(user: current_user)
    @notices.update_all(seen: true)
  end
end
