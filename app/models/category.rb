class Category < ApplicationRecord
  has_many :eventposts
  validates :name, presence: true
end
