class VibrationsController < ApplicationController
  before_action :authenticate_user!

  def show
    ViewVibrationJob.perform_later(vibration: vibration, user: current_user)
    @vibration_presenter = VibrationPresenter.new(vibration: vibration, current_user: current_user)
    @reply_vibrations_in_presenter = vibration.reply_vibrations.includes(
      :liked_users, :bookmarked_users, :revibrationed_users, :user
    ).order(created_at: :desc).map do |reply_vibration|
      VibrationPresenter.new(vibration: reply_vibration, current_user: current_user)
    end
  end

  def create
    @vibration = Vibration.new(vibration_params.merge(user: current_user))

    if @vibration.save
      respond_to do |format|
        format.html { redirect_to dashboard_path }
        format.turbo_stream
      end
    end
  end

  private

  def vibration_params
    params.require(:vibration).permit(:body)
  end

  def vibration
    @vibration ||= Vibration.find(params[:id])
  end
end
