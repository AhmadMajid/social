class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @vibrations = Vibration.includes(:user).order(created_at: :desc).map { |vibration| VibrationPresenter.new(vibration) }
  end
end
