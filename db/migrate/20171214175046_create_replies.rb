class CreateReplies < ActiveRecord::Migration[5.1]
  def change
    create_table :replies do |t|
      t.text :content, null: false
      t.references :user, foreign_key: true, null: false
      t.references :comment, foreign_key: true, null: false

      t.timestamps
    end
  end
end
