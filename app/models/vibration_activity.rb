class VibrationActivity < ApplicationRecord
  belongs_to :user
  belongs_to :vibration
  belongs_to :actor, class_name: "User"

  VERBS = %w[vibrationed liked replied revibrationed].freeze

  validates :verb, presence: true, inclusion: { in: VERBS }
end
