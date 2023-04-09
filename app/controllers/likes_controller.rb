class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.create(vibration: vibration)
    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.turbo_stream
    end
  end

  def destroy
    @like = vibration.likes.find(params[:id])
    @like.destroy
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
