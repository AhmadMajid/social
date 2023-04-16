class Vibration < ApplicationRecord
  HASHTAG_REGEX = /(#\w+)/

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
  has_and_belongs_to_many :hashtags
  belongs_to :parent_vibration,
             inverse_of: :reply_vibrations,
             foreign_key: :parent_vibration_id,
             class_name: "Vibration",
             optional: true,
             counter_cache: :reply_vibrations_count
  has_many :reply_vibrations, foreign_key: :parent_vibration_id, class_name: "Vibration"

  before_save :parse_and_save_hashtags
  def parse_and_save_hashtags
    matches = body.scan(HASHTAG_REGEX)
    return if matches.empty?

    matches.flatten.each do |tag|
      hashtag = Hashtag.find_or_create_by(tag: tag.delete("#"))
      hashtags << Hashtag.find_or_create_by(tag: tag.delete("#"))
    end
  end
end
