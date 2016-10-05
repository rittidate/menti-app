class CreateConversationReplies < ActiveRecord::Migration
  def change
    create_table :conversation_replies do |t|
      t.references :conversation, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string  :reply
      t.boolean :seen
      t.timestamps null: false
    end
  end
end
