# == Schema Information
#
# Table name: transactions
#
#  id               :integer          not null, primary key
#  transaction_type :integer          default(0)
#  user_id          :integer
#  course_id        :integer
#  amount           :integer
#  card_type        :string
#  masked_number    :string
#  status           :string
#  ref              :string
#  notes            :string
#  transaction_date :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_transactions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_77364e6416  (user_id => users.id)
#

class Transaction < ActiveRecord::Base
  enum transaction_type: { deposit: 0, withdrawal: 1, braintree: 2, pool_activity: 3 }

  belongs_to :user
  belongs_to :course

end
