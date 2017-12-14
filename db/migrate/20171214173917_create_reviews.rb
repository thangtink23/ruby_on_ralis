class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.float :rate
      t.string :title
      t.text :content
      t.integer :like_count
      t.string :image
      t.references :user, foreign_key: true
      t.references :hotels, foreign_key: true

      t.timestamps
    end
  end
end
