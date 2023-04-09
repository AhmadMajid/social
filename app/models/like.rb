class Like < ApplicationRecord
  belongs_to :vibration
  belongs_to :user

  validates :user_id, uniqueness: { scope: :vibration_id }
end
