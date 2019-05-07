class Category < ApplicationRecord
  has_many :eventposts
  validates :name, presence: true
  
  
  def self.categorys
      Category.joins(:eventposts).group(:id, :name).count
                            
  end
end
