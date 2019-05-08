class CreateEventpostComments < ActiveRecord::Migration[5.2]
  def change
    create_table :eventpost_comments do |t|
      t.string :user_name
      t.string :user_name_id
      t.string :content
      t.integer :user_id
      t.references :eventpost, foreign_key: true

      t.timestamps
    end
    # user_idにIndexを付けてない（必要なら今後追加する）
    add_index :eventpost_comments, [:eventpost_id, :created_at] 

  end
end
