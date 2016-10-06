class AddConversationToNotification < ActiveRecord::Migration
  def change
    add_reference :notifications, :conversation
  end
end
