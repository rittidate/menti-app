class CreateCategorysUsersRelations < ActiveRecord::Migration
  def change
    create_table :categorys_users_relations do |t|
      t.references :category
      t.references :user
      t.integer    :value, default: 0
      t.integer    :desire_value, default: 0
      t.timestamps null: false
    end
  end
end
