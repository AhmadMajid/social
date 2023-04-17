class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @vibration_activities = current_user.vibration_activities.order(created_at: :desc).page(1).per(5)
    @vibration_activities_data = {
      vibration_activities: @vibration_activities.map do |vibration_activity|
        VibrationPresenter.new(vibration: vibration_activity.vibration, current_user: current_user, vibration_activity: vibration_activity)
      end,
      page: @vibration_activities.current_page,
      next_page: @vibration_activities.next_page,
      last_page: @vibration_activities.last_page?,
      total_pages: @vibration_activities.total_pages
    }
  end
end
