class VibrationPresenter
  include ActionView::Helpers::DateHelper
  include Rails.application.routes.url_helpers

  def initialize(vibration:, current_user:)
    @vibration = vibration
    @current_user = user
  end

  attr_reader :vibration, :current_user

  delegate :user, :body, :likes_count, to: :vibration
  delegate :display_name, :username, :avatar, to: :user

  def created_at
    if (Time.zone.now - vibration.created_at) > 1.day
      vibration.created_at.strftime("%b %-d")
    else
      time_ago_in_words(vibration.created_at)
    end
  end

  def like_vibration_url
    if vibration_liked_by_current_user?
      vibration_like_path(vibration, current_user.likes.find_by(vibration: vibration))
    else
      vibration_likes_path(vibration)
    end
  end

  def turbo_data_method
    if vibration_liked_by_current_user?
      "delete"
    else
      "post"
    end
  end

  def like_heart_image
    if vibration_liked_by_current_user?
      "heart-filled.png"
    else
      "heart-unfilled.png"
    end
  end

  private

  def vibration_liked_by_current_user
    @vibration_liked_by_current_user ||= vibration.liked_users.include?(current_user)
  end
  alias_method :vibration_liked_by_current_user?, :vibration_liked_by_current_user
end
