class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    following_users = current_user.following_users
    @vibrations = Vibration.includes(:liked_users, :bookmarked_users, :revibrationed_users, :user).where(user: following_users).order(created_at: :desc).map do |vibration|
      VibrationPresenter.new(vibration: vibration, current_user: current_user)
    end
  end
end
