# == Schema Information
#
# Table name: conversation_replies
#
#  id              :integer          not null, primary key
#  conversation_id :integer
#  user_id         :integer
#  reply           :string
#  seen            :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_conversation_replies_on_conversation_id  (conversation_id)
#  index_conversation_replies_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_8ea2978e91  (user_id => users.id)
#  fk_rails_a0c1bc76e5  (conversation_id => conversations.id)
#

class ConversationReply < ActiveRecord::Base

  belongs_to :conversation
  belongs_to :user

  

end
