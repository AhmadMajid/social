class ViewVibrationJob < ApplicationJob
  queue_as :default

  def perform(vibration: , user:)
    View.create(vibration: vibration, user: user) unless vibration_viewed?(vibration: vibration, user: user)
  end

  private

  def vibration_viewed?(vibration:, user:)
    View.exists?(user: user, vibration: vibration)
  end
end
