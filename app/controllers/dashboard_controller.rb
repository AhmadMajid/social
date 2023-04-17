class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @vibration_activities = current_user.vibration_activities.order(created_at: :desc).map do |vibration_activity|
      VibrationPresenter.new(vibration: vibration_activity.vibration, current_user: current_user, vibration_activity: vibration_activity)
    end
  end
end
