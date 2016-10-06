class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.references :user_one, references: :users
      t.references :user_two, references: :users
      t.integer :status
      t.timestamps null: false
    end
  end
end
