class Eventpost < ApplicationRecord
  
  belongs_to :user
  belongs_to :category

  validates :title, presence: true
  validates :sub_title, presence: true
  validates :content, presence: true
  validates :category_id, presence: true
  # validates :image, presence: true
  
  # 記事（まとめて高速化）
  def self.eventposts
    Eventpost.joins(:category).order(Arel.sql("created_at desc"))
  end
  
  # 人気の記事一覧
  def popular_eventposts
    # Eventpost.joins(:eventpost_comments).order(Arel.sql("created_at desc"))
  end

  # 検索
  def self.search(search)
    return Post.all unless search
    Eventpost.where(['title LIKE ?', "%#{search}%"])
  end
  
  # アーカイブ
  def self.archives
    # Railsでブログアプリに月別アーカイブを導入(参考)
   
    Eventpost.group("strftime('%Y%m', created_at)").order(Arel.sql("strftime('%Y%m', created_at) desc")).count
    
    # Eventpost.group("date('%Y%m',created_at)").count
    # Eventpost.group("DATE(created_at, '%Y%m%d')").count
    # => ["2019-05-07", 1]
    

  end
end
