class Revibration < ApplicationRecord
  belongs_to :user
  belongs_to :vibration, counter_cache: :revibrations_count

  validates :user_id, uniqueness: { scope: :vibration_id }
end
