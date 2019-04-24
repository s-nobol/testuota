Rails.application.routes.draw do
  
   # 企業ポリシーページ
  get 'static_pages/home'
  get 'static_pages/about'
  get 'static_pages/help'
  get 'static_pages/agreement'
  get 'static_pages/policy'
  get 'static_pages/corporate'
 
  # サインアップ
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  
  root "users#new"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users 
end


# gitの初期設定
# $ git config --global user.name "kiyo1301"
# $ git config --global user.email ka1301@outlook.jp

# スティックページ作成

# 初期ページ作成
# rails g controller StaticPages home about help agreement policy corporate

# ユーザー作成
# rails g model User name:string email:string password:string
# rails g controller Users new show index edit

# パスワード設定

# ユーザーカラム追加
# rails g migration add_image_to_users (ひとこと:message　メールの受信:mail ユーザー画像:image)

# post
# rails g model Post content:text user:references
# rails g controller Posts show

# comment
# rails g model Comment content:string user:references post:references
# rails g controller Comments new 

# (まとめ記事、撮り鉄スポット)ポスト
# rails g model Eventpost content:text image:string
# rails g model Locationpost content:text image:string