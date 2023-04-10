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
end
