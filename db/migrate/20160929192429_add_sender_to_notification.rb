class AddSenderToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :sender_id, :integer
  end
end
