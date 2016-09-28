# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  parent_id  :integer
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ActiveRecord::Base
  has_many :categorys_users_relations

  def category_user_exist?(user, category_id)
    CategorysUsersRelation.joins(:category).where(categories: {parent_id: category_id}, user: user).present?
  end

  def category_course(user, category_id)
    Course.joins("INNER JOIN categories ON courses.categories_id = categories.id").where(categories_id: category_id, user: user)
  end
end
