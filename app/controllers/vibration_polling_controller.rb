class VibrationPollingController < ApplicationController
  before_action :authenticate_user!

  def index
    @vibration_activities = current_user.vibration_activities.order(created_at: :desc).where("vibration_id > ?", params[:latest_vibration_id])
    @vibration_activities_data = {
      vibration_activities: @vibration_activities.map do |vibration_activity|
        VibrationPresenter.new(vibration: vibration_activity.vibration, current_user: current_user, vibration_activity: vibration_activity)
      end
    }

    respond_to do |format|
      format.turbo_stream
    end
  end
end
