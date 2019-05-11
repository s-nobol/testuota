class Eventpost < ApplicationRecord
  
  has_many :eventpost_comments
  belongs_to :user
  belongs_to :category
  mount_uploader :image, EventpostImageUploader 
  validates :title, presence: true
  validates :sub_title, presence: true
  validates :content, presence: true
  validates :category_id, presence: true
  validate  :image_size
  
  # 記事（まとめて高速化）
  # def self.eventposts
  #   Eventpost.joins(:category).order(Arel.sql("created_at desc"))
  # end
  
  # 人気の記事一覧
  def self.popular_eventposts_1
    Eventpost.joins(:eventpost_comments).group(:eventpost_id).order(Arel.sql("count(eventpost_id) desc")).limit(10)
  end
  
  def self.popular_eventposts_2
    Eventpost.find(EventpostComment.group(:eventpost_id).order(Arel.sql('count(eventpost_id) desc')).limit(6).pluck(:eventpost_id))
  end
  

  # 検索
  def self.search(search)
    return Eventpost.all unless search
    Eventpost.where(['title LIKE ?', "%#{search}%"])
  end
  
  # アーカイブ
  def self.archives
    # Railsでブログアプリに月別アーカイブを導入(参考)
    if Rails.env.production?
      Eventpost.group("date_part('year' ,created_at)","date_part('month' ,created_at)").count
      #うまくいったっぽい
    else
      Eventpost.group("strftime('%Y%m', created_at)").order(Arel.sql("strftime('%Y%m', created_at) desc")).count
    end
  end
  
  private

    # アップロードされた画像のサイズをバリデーションする
    def image_size
      if image.size > 5.megabytes
        errors.add(:image, "should be less than 5MB")
      end
    end
end

# ExampleLog.group("date_part('hour', timezone('Australia/Sydney', example_logs.created_at))").count7
# where({blog_id: blog.id}).group_by_month(:created_at, format: "%Y年%b", reverse: true, series: false).count
# Eventpost.group("date_part('month' ,created_at)").count
# Eventpost.group('date("%y",created_at)').count
# dateを正規表現で変換してみる
# => {"2019-05-07"=>5} 考えてみる
# select 
# date_part('year', created) as year, 
# date_part('month', created) as month,
# sum(price) as sum_price
# from sales
# group by year,month
# order by year,month;
