class AddMentorStatusToUser < ActiveRecord::Migration
  def change
    add_column :users, :mentor_status, :boolean, default: true
  end
end
