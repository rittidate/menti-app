class RemoveCourseIdFromCourse < ActiveRecord::Migration
  def change
    remove_column :courses, :courses_id
  end
end
