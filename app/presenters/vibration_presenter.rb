class VibrationPresenter
  include ActionView::Helpers::DateHelper
  include Rails.application.routes.url_helpers

  def initialize(vibration:, current_user:, vibration_activity: nil)
    @vibration = vibration
    @current_user = user
    @vibration_activity = vibration_activity
  end

  delegate :user, :body, :likes_count, :revibrations_count, :views_count, :reply_vibrations_count, to: :vibration
  delegate :display_name, :username, to: :user

  attr_reader :vibration, :current_user, :vibration_activity

  def render_vibration_activity?
    return false unless vibration_activity

    vibration_activity.verb.in?(VibrationActivity::VERBS - %w[vibrationed])
  end

  def vibration_activity_html
    case vibration_activity.verb
    when "liked"
      "<p class=\"fw-bold fs-6 text-muted mb-0\" style=\"margin-left: 5rem; font-size: 13px !important;\">#{vibration_activity.actor.display_name} liked</p>"
    end
  end

  def created_at
    if (Time.zone.now - vibration.created_at) > 1.day
      vibration.created_at.strftime("%b %-d")
    else
      time_ago_in_words(vibration.created_at)
    end
  end

  def body_html(p_class: "")
    texts = vibration.body.split(" ").map do |word|
      if word.include?("#") || word.include?("@")
        "<a class=\"social-link\">#{word}</a>"
      else
        word
      end
    end
    "<p class=\"#{p_class}\">#{texts.join(" ")}</p>"
  end

  def avatar
    return user.avatar if user.avatar.present?

    ActionController::Base.helpers.asset_path("user.png")
  end

  def like_vibration_url(source: "vibration_card")
    if vibration_liked_by_current_user?
      vibration_like_path(vibration, current_user.likes.find_by(vibration: vibration), source: source)
    else
      vibration_likes_path(vibration, source: source)
    end
  end

  def turbo_like_data_method
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

  def bookmark_vibration_url(source: "vibration_card")
    if vibration_bookmarked_by_current_user?
      vibration_bookmark_path(vibration, current_user.bookmarks.find_by(vibration: vibration), source: source)
    else
      vibration_bookmarks_path(vibration, source: source)
    end
  end

  def turbo_bookmark_data_method
    if vibration_bookmarked_by_current_user?
      "delete"
    else
      "post"
    end
  end

  def bookmark_image
    if vibration_bookmarked_by_current_user?
      "bookmark-filled.png"
    else
      "bookmark-unfilled.png"
    end
  end

  def bookmark_text
    if vibration_bookmarked_by_current_user?
      "Bookmarked"
    else
      "Bookmark"
    end
  end

  def revibration_vibration_url(source: "vibration_card")
    if vibration_revibrationed_by_current_user?
      vibration_revibration_path(vibration, current_user.revibrations.find_by(vibration: vibration), source: source)
    else
      vibration_revibrations_path(vibration, source: source)
    end
  end

  def turbo_revibration_data_method
    if vibration_revibrationed_by_current_user?
      "delete"
    else
      "post"
    end
  end

  def revibration_image
    if vibration_revibrationed_by_current_user?
      "revibration-filled.png"
    else
      "revibration-unfilled.png"
    end
  end

  private

  def vibration_liked_by_current_user
    @vibration_liked_by_current_user ||= vibration.liked_users.include?(current_user)
  end
  alias_method :vibration_liked_by_current_user?, :vibration_liked_by_current_user

  def vibration_bookmarked_by_current_user
    @vibration_bookmarked_by_current_user ||= vibration.bookmarked_users.include?(current_user)
  end
  alias_method :vibration_bookmarked_by_current_user?, :vibration_bookmarked_by_current_user

  def vibration_revibrationed_by_current_user
    @vibration_revibrationed_by_current_user ||= vibration.revibrationed_users.include?(current_user)
  end
  alias_method :vibration_revibrationed_by_current_user?, :vibration_revibrationed_by_current_user
end
