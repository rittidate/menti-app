class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, index: true, foreign_key: true
      t.references :transaction
      t.string     :status
      t.string     :notification_type
      t.timestamps null: false
    end
  end
end
