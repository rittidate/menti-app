class AddOwnerCourseToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :course_owner_id, :integer
  end
end
