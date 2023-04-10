class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_many :vibrations, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_vibrations, through: :likes, source: :vibration
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_vibrations, through: :bookmarks, source: :vibration

  validates :username, uniqueness: { case_sensitive: false }, allow_blank: true

  before_save :set_display_name, if: -> { username.present? && display_name.blank? }
  def set_display_name
    self.display_name = username.humanize
  end
end
