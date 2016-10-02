# == Schema Information
#
# Table name: courses
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  categories_id :integer
#  price         :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_courses_on_categories_id  (categories_id)
#  index_courses_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_b3c61f05ef  (user_id => users.id)
#

class Course < ActiveRecord::Base
  belongs_to :user
  belongs_to :categories, class_name: 'Category'

end
