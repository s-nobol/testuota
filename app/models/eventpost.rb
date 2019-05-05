class Eventpost < ApplicationRecord
  
  belongs_to :user
  
  validates :title, presence: true
  validates :sub_title, presence: true
  validates :content, presence: true
  validates :category_id, presence: true
  # validates :image, presence: true

end
