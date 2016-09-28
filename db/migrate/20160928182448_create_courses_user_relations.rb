class CreateCoursesUserRelations < ActiveRecord::Migration
  def change
    create_table :courses_user_relations do |t|
      t.references :course
      t.references :user
      t.timestamps null: false
    end
  end
end
