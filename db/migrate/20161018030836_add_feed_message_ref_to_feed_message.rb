class AddFeedMessageRefToFeedMessage < ActiveRecord::Migration
  def change
    add_reference :feed_messages, :ref_feed_message
  end
end
