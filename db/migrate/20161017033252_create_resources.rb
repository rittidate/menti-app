class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string    :resource_name
      t.integer   :resource_type
      t.references :user
      t.attachment :document
      t.timestamps null: false
    end
  end
end
