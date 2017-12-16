class AddColumsToNotification < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :review, :reference
  end
end
