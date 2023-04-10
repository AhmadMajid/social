class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @vibrations = Vibration.includes(:liked_users, :bookmarked_users, :user).order(created_at: :desc).map do |vibration|
      VibrationPresenter.new(vibration: vibration, current_user: current_user)
    end
  end
end
