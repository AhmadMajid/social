class Like < ApplicationRecord
  belongs_to :vibration, counter_cache: :likes_count
  belongs_to :user

  validates :user_id, uniqueness: { scope: :vibration_id }
end
