class AddUserDetailToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string     :username,           uniqe: true
      t.string     :first_name
      t.string     :middle_name
      t.string     :last_name
      t.string     :address
      t.string     :city
      t.string     :state
      t.string     :zipcode
      t.date       :birthdate
      t.string     :country,            :limit => 2
      t.string     :prefered_language,  :limit => 2
      t.integer    :user_type
      t.string     :mobile_phone
      t.boolean    :terms_of_service
      t.integer    :default_payment_id
      t.string     :gender
      t.integer    :security_question_id
      t.string     :security_question_answer
    end
  end
end
