class AddCourseUserRelationsToRating < ActiveRecord::Migration
  def change
    add_reference :ratings, :courses_user_relation
  end
end
