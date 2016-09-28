# == Schema Information
#
# Table name: payments
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  card_type     :string
#  masked_number :string
#  token         :string
#  customer_id   :string
#  is_public     :boolean          default(TRUE)
#  company       :string
#  address       :string
#  address_ext   :string
#  city          :string
#  state         :string
#  zipcode       :string
#  country       :string(2)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_payments_on_user_id  (user_id)
#

class Payment < ActiveRecord::Base
  belongs_to :user
  after_create :set_default_payment
  private
  def set_default_payment
    if user.default_payment_id.nil?
      user.update!(default_payment: self)
    end
  end
end
