class Hashtag < ApplicationRecord
  has_and_belongs_to_many :vibrations

  validates :tag, presence: true, uniqueness: { case_sensitive: false }
end
