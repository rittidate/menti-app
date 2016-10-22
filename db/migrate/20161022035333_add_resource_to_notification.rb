class AddResourceToNotification < ActiveRecord::Migration
  def change
    add_reference :notifications, :resource
  end
end
