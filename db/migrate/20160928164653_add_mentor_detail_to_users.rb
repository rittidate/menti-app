class AddMentorDetailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :about, :string
    add_column :users, :program, :string
    add_column :users, :terms, :string
  end
end
