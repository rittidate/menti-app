# == Schema Information
#
# Table name: notifications
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  transaction_id    :integer
#  status            :string
#  notification_type :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  sender_id         :integer
#  seen              :boolean          default(FALSE)
#  conversation_id   :integer
#  resource_id       :integer
#
# Indexes
#
#  index_notifications_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_b080fb4855  (user_id => users.id)
#

class Notification < ActiveRecord::Base
  enum notification_type: { payment: 'payment', course: 'course', message: 'message', resource: 'resource' }

  belongs_to :user
  belongs_to :sender, :class_name => "User"
  belongs_to :conversation
  belongs_to :resource

  def course
    Transaction.find(self.transaction_id).course
  end

end
