Rails.application.routes.draw do
  
  
  # 企業ポリシーページ
  get 'static_pages/home'
  # get 'static_pages/about'
  # get 'static_pages/help'
  # get 'static_pages/agreement'
  # get 'static_pages/policy'
  # get 'static_pages/corporate'
  
  # 検索
  get 'eventpost_search', to: 'static_pages#search'
  get 'post_search', to: 'posts#search'
  
  # 人気記事一覧ページ
  get 'postpopular', to: 'posts#popular'
  
  # アーカイブ
  get 'archive/:yyyymm', to: 'static_pages#archive', as: :archive
  
  # ログイン
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
 
  # サインアップ
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  
  # ユーザー画像設定
  post 'update_image', to: 'users#user_image'
  
  # ホーム
  root "static_pages#home"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users 
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :posts
  resources :comments,            only: [:show, :create, :destroy]
  resources :likes,               only: [ :show, :create, :destroy]
  resources :messages, only: [:show]
  resources :eventposts
  resources :categorys, only: [:show, :new, :create, :destroy]
  resources :eventpost_comments, only: [:show, :create, :destroy]

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

# いいね機能作成
# rails g model Like  user:references post:references
# rails g controller Likes show

# password_resetの作成
# rails g controller PasswordResets new edit --no-test-framework
# rails g migration add_reset_to_users reset_digest:string reset_sent_at:datetime

# password_reset_mailer comment_mailer 作成
# rails g mailer UserMailer comment password_reset

# 画像アップロード作成(user, post)
# rails generate uploader Picture
# rails generate uploader Image

# 管理者ユーザー作成
# rails g migration add_admin_to_users admin:boolean

# まとめ記事モデル(ちゃんと考えて作成する)
# rails g model Eventpost title:string sub_title:text content:text image:string category_id:integer user:references
# rails g controller Eventposts new show edit index


# カテゴリー作成
# rails g model Category name:string 
# rails g controller Categorys
# seed.rb // times.do  posts.createを15から10に変更した


# 検索 or アーカイブ (2つともコントローラーは作成せずにStaticPageに付随させた)
# rails g controller static_pages search archive
# test/search_test.rb
# test/archive_test.rb


# コメントモデル(Event_post用)
# rails g model Eventpost_comment content:string user_id:integer eventpost:references
# rails g controller Eventpost_comments
# rails g integration_test eventpost_comment

# メッセージfeed作成
# rails g controller Messages show

# ここから！！！！！！
# AWS_s3_uploader作成

# 撮り鉄スポットポスト(作成しなくてもいい)
# rails g model Locationpost title:string content:text image:string
# rails g controller Locationposts new show edit index
