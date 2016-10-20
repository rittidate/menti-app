class CreateConversationHistories < ActiveRecord::Migration
  def change
    create_table :conversation_histories do |t|
      t.references :conversation
      t.references :user
      t.references :conversation_replies
      t.timestamps null: false
    end
  end
end
