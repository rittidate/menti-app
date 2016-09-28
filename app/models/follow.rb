# == Schema Information
#
# Table name: follows
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  follower_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_follows_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_32479bd030  (user_id => users.id)
#

class Follow < ActiveRecord::Base
  belongs_to :user
  belongs_to :follower, class_name: 'User'
  scope :mentors, -> { joins("INNER JOIN users ON follows.follower_id = users.id").where.not('user_type = ?', 0) }
  scope :mentees, -> { joins("INNER JOIN users ON follows.follower_id = users.id").where.not('user_type = ?', 1) }
end
