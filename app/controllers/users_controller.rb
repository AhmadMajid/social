class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    redirect_to profile_path if params[:id].to_i == current_user.id
    @user = User.find(params[:id])
    @vibration_presenters = @user.vibrations.order(created_at: :desc).map do |vibration|
      VibrationPresenter.new(vibration: vibration, current_user: current_user)
    end
  end
end
