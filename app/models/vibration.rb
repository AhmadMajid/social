class Vibration < ApplicationRecord
  belongs_to :user

  validates :body, presence: true, length: { maximum: 280 }
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_users, through: :bookmarks, source: :user
  has_many :revibrations, dependent: :destroy
  has_many :revibrationed_users, through: :revibrations, source: :user
  has_many :views, dependent: :destroy
  has_many :viewed_users, through: :views, source: :user
  belongs_to :parent_vibration,
             inverse_of: :reply_vibrations,
             foreign_key: :parent_vibration_id,
             class_name: "Vibration",
             optional: true,
             counter_cache: :reply_vibrations_count
  has_many :reply_vibrations, foreign_key: :parent_vibration_id, class_name: "Vibration"
end
