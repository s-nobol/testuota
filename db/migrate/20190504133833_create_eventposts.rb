class CreateEventposts < ActiveRecord::Migration[5.2]
  def change
    create_table :eventposts do |t|
      t.string :title
      t.text :sub_title
      t.text :content
      t.string :image
      t.integer :category_id
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :eventposts, [:user_id, :category_id, :created_at]

  end
end
