class RevibrationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @revibration = current_user.revibrations.create(vibration: vibration)
    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.turbo_stream
    end
  end

  def destroy
    @revibration = vibration.revibrations.find(params[:id])
    @revibration.destroy
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
