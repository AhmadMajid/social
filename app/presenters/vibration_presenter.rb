class VibrationPresenter
  include ActionView::Helpers::DateHelper

  def initialize(vibration)
    @vibration = vibration
  end

  attr_reader :vibration

  delegate :user, :body, :likes, to: :vibration
  delegate :display_name, :username, :avatar, to: :user

  def created_at
    if (Time.zone.now - vibration.created_at) > 1.day
      vibration.created_at.strftime("%b %-d")
    else
      time_ago_in_words(vibration.created_at)
    end
  end
end
