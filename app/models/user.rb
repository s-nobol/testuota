class User < ApplicationRecord
  
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  mount_uploader :image, ImageUploader
  attr_accessor :cookies_token, :reset_token
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true
  
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :message, length: { maximum: 256 }
  validate  :image_size
  
  
  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
    # ランダムなトークンを返す
  def create_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためにユーザーをデータベースに記憶する
  def create_cookies_digest
    self.cookies_token = create_token
    update_attribute(:cookies_digest, User.digest(cookies_token))
  end
  
  # パスワードの再発行トークンを作成、保存する
  def create_reset_digest
    self.reset_token = create_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end
  
  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:cookies_digest, nil)
  end
  
    # パスワード再設定の期限が切れている場合はtrueを返す
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  private

    # アップロードされた画像のサイズをバリデーションする
    def image_size
      if image.size > 5.megabytes
        errors.add(:image, "画像サイズが大きすぎます5MB以下にして下さい")
      end
    end
end
