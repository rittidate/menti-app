class AddOwnerToCoursesUserRelation < ActiveRecord::Migration
  def change
    add_column :courses_user_relations, :owner_id, :integer
  end
end
