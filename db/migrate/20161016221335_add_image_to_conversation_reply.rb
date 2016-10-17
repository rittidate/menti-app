class AddImageToConversationReply < ActiveRecord::Migration
  def self.up
    change_table :conversation_replies do |t|
      t.has_attached_file :image
    end
  end

  def self.down
    drop_attached_file :conversation_replies, :image
  end
end
