Rails.application.routes.draw do
  
   # 企業ポリシーページ
  get 'static_pages/home'
  get 'static_pages/about'
  get 'static_pages/help'
  get 'static_pages/agreement'
  get 'static_pages/policy'
  get 'static_pages/corporate'
  
  # ログイン
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
 
  # サインアップ
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  
  root "static_pages#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users 
  # resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :posts
  resources :comments,            only: [:show, :create, :destroy]
  resources :likes,               only: [ :show, :create, :destroy]
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
# rails g migration add_password_digest_to_users  

# セッション作成
# rails g controller Sessions new
# rails g migration add_cookies_to_users cookies_digest:string

# ユーザーカラム追加
# rails g migration add_image_to_users (ひとこと:message　メールの受信:mail ユーザー画像:image)

# post
# rails g model Post title:string content:text location:string picture:string sound:string user:references
# rails g controller Posts new show edit index  

# comment
# rails g model Comment content:string user:references post:references
# rails g controller Comments new 

# ここから！！！！！！
# いいね機能作成
# rails g model Like  user:references post:references
# rails g controller Likes show

# password_resetの作成
# rails g controller PasswordResets new edit 
# rails g migration add_reset_to_users reset_digest:string reset_sent_at:datetime


# (まとめ記事、撮り鉄スポット)ポスト
# rails g model Eventpost content:text image:string
# rails g model Locationpost content:text image:string