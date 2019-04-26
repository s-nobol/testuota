class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :content
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
    #<-インデックスを複合キーにて追加
    add_index :comments , [:user_id, :post_id, :created_at] 
  end
end
