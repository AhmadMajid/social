class VibrationsController < ApplicationController
  before_action :authenticate_user!

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
end
