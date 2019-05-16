class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 400 }
  # validates :picture, presence: true
  validate  :picture_size
  
  # 検索
  def self.post_search
    return Post.all unless search
    Post.where(['title LIKE ?', "%#{@search}%"])
  end
  
  # 人気一覧
  def self.popular
    
    Post.find(
              Like.group(:post_id).order(Arel.sql('count(post_id) desc'))
              .limit(5).pluck(:post_id)
              )
  end
  
  private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 10.megabytes
        errors.add(:picture, "should be less than 10MB")
      end
    end
end
