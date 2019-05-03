class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  # default_scope -> { order(created_at: :desc) }
  validates_uniqueness_of :post_id, scope: :user_id
end
