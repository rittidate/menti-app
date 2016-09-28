class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.references :user, index: true, foreign_key: true
      t.references :follower, references: :users
      t.timestamps null: false
      t.timestamps null: false
    end
  end
end
