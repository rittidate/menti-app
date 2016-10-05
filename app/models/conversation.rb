# == Schema Information
#
# Table name: conversations
#
#  id          :integer          not null, primary key
#  user_one_id :integer
#  user_two_id :integer
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Conversation < ActiveRecord::Base
  enum status: { unavailible: 0, availible: 1, unseen: 2 }

  belongs_to :user_one, :class_name => "User"
  belongs_to :user_two, :class_name => "User"

  has_many :conversation_replies

  def room_exist(user_one, user_two)
    Conversation.where('(user_one_id = ? AND user_two_id = ?) OR (user_one_id = ? AND user_two_id = ?)', user_one, user_two, user_two, user_one)
  end

end
