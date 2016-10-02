# == Schema Information
#
# Table name: ratings
#
#  id                       :integer          not null, primary key
#  user_id                  :integer
#  giver_id                 :integer
#  value                    :integer          default(0), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  courses_user_relation_id :integer
#
# Indexes
#
#  index_ratings_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_a7dfeb9f5f  (user_id => users.id)
#

class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :giver, :class_name => "User"
  
  has_many :courses_user_relations
end
