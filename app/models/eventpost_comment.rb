class EventpostComment < ApplicationRecord
  belongs_to :eventpost
  validates :eventpost_id, presence: true
  validates :content, presence: true, length: { maximum: 256 }

end
