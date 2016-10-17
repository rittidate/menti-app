# == Schema Information
#
# Table name: resources
#
#  id                    :integer          not null, primary key
#  resource_name         :string
#  resource_type         :integer
#  user_id               :integer
#  document_file_name    :string
#  document_content_type :string
#  document_file_size    :integer
#  document_updated_at   :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class Resource < ActiveRecord::Base
  enum resource_type: { default: 0, user: 1 }
  belongs_to :user

  has_attached_file :document
  validates_attachment :document, :content_type => {:content_type => %w(image/jpeg image/jpg image/png application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document)}
end
