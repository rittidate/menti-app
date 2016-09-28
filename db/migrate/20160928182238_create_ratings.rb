class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :user, index: true, foreign_key: true
      t.references :giver, references: :users
      t.integer     :value, null: false, default: 0
      t.timestamps null: false
    end
  end
end
