class AddEditToUsers < ActiveRecord::Migration[5.2]
  def change
    
    # ユーザーモデルに新しいカラムを追加する（ユーザー画像、一言、住所、性別、誕生日　、メールの通知、メッセージの通知、）
    # image message address gender birthday notice_email notice_message
    add_column :users, :image, :string
    add_column :users, :message, :text
    add_column :users, :address, :string #ドロップリスト
    add_column :users, :gender, :string #ドロップリスト
    add_column :users, :birthday, :date　
    add_column :users, :notice_email, :boolean, default: true
    add_column :users, :notice_message, :boolean, default: true
  end
end
