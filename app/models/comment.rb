class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  validates :user_id, presence: true  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 256 }
end
