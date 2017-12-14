class CreateHotels < ActiveRecord::Migration[5.1]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :address
      t.integer :phone
      t.text :description
      t.integer :star, default: 0
      t.float :rate_sum, default: 0
      t.integer :rate_count, default: 0
      t.string :avatar
      t.float :max_price
      t.float :min_price

      t.timestamps
    end
  end
end
