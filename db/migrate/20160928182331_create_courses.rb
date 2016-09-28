class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.references :user, index: true, foreign_key: true
      t.references :courses, :categories, index: true
      t.integer :price
      t.timestamps null: false
    end
  end
end
