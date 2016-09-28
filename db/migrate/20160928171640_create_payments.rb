class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.belongs_to :user, index: true
      t.string :card_type
      t.string :masked_number
      t.string :token
      t.string :customer_id
      t.boolean :is_public, default: true
      t.string :company
      t.string :address
      t.string :address_ext
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :country,            :limit => 2
      t.timestamps null: false
    end
  end
end
