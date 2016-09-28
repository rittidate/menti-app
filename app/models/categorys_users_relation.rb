# == Schema Information
#
# Table name: categorys_users_relations
#
#  id           :integer          not null, primary key
#  category_id  :integer
#  user_id      :integer
#  value        :integer          default(0)
#  desire_value :integer          default(0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class CategorysUsersRelation < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
end
