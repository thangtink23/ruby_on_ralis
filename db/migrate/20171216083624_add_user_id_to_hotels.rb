class AddUserIdToHotels < ActiveRecord::Migration[5.1]
  def change
    add_column :hotels, :user_id, :integer, :default => 1
  end
end
