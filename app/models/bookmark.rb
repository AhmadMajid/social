class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :vibration

  validates :user_id, uniqueness: { scope: :vibration_id }
end
