# == Schema Information
#
# Table name: courses_user_relations
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :integer
#

class CoursesUserRelation < ActiveRecord::Base
  belongs_to :user
  belongs_to :course, :class_name => "Course"
  belongs_to :owner, :class_name => "User"

end
