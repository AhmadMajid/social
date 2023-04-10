class View < ApplicationRecord
  belongs_to :user
  belongs_to :vibration, counter_cache: :views_count

  validates :user_id, uniqueness: { scope: :vibration_id }
end
