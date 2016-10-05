class AddNotificationToConversationReply < ActiveRecord::Migration
  def change
    add_column :conversation_replies, :notify, :boolean, default: false
  end
end
