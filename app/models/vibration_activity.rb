class VibrationActivity < ApplicationRecord
  belongs_to :user
  belongs_to :vibration

  VERBS = %w[vibrationed liked replied revibrationed].freeze

  validates :verb, presence: true, inclusion: { in: VERBS }
end
