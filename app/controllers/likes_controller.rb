class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.create(vibration: vibration)
    Notification.create(user: vibration.user, actor: current_user, verb: "liked-vibration", vibration: vibration)
    VibrationActivity.create(user: vibration.user, actor: current_user, vibration: vibration, verb: "liked")
    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.turbo_stream
    end
  end

  def destroy
    @like = vibration.likes.find(params[:id])
    @like.destroy
    VibrationActivity.where(user: vibration.user, actor: current_user, vibration: vibration, verb: "liked").destroy_all
    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.turbo_stream
    end
  end

  private

  def vibration
    @vibration ||= Vibration.find(params[:vibration_id])
  end
end
