class CreateFeedMessages < ActiveRecord::Migration
  def change
    create_table :feed_messages do |t|
      t.references :reciever, references: :users
      t.references :sender, references: :users
      t.string     :message
      t.attachment :image
      t.timestamps null: false
    end
  end
end
