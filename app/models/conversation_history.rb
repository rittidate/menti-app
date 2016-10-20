# == Schema Information
#
# Table name: conversation_histories
#
#  id                      :integer          not null, primary key
#  conversation_id         :integer
#  user_id                 :integer
#  conversation_replies_id :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class ConversationHistory < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user

end
