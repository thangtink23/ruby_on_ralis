class AddStatusToHotels < ActiveRecord::Migration[5.1]
  def change
    add_column :hotels, :status, :string, default: "pending"
  end
end
