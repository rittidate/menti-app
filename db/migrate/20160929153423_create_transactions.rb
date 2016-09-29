class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :transaction_type , default: 0
      t.references :user, index: true, foreign_key: true
      t.references :course
      t.integer :amount
      t.string :card_type
      t.string :masked_number
      t.string :status
      t.string :ref
      t.string :notes
      t.datetime :transaction_date

      t.timestamps null: false
    end
  end
end
