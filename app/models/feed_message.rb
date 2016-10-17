# == Schema Information
#
# Table name: feed_messages
#
#  id                 :integer          not null, primary key
#  reciever_id        :integer
#  sender_id          :integer
#  message            :string
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class FeedMessage < ActiveRecord::Base
  belongs_to :reciever, :class_name => "User"
  belongs_to :sender, :class_name => "User"

  has_attached_file :image, styles: { thumb: "300x300>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
