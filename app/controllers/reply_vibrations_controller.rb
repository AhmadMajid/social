class ReplyVibrationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @vibration = vibration.reply_vibrations.create(vibration_params.merge(user: current_user))

    if @vibration.save
      respond_to do |format|
        format.html { redirect_to dashboard_path }
        format.turbo_stream
      end
    end
  end

  private

  def vibration
    @vibration ||= Vibration.find(params[:vibration_id])
  end

  def vibration_params
    params.require(:vibration).permit(:body)
  end
end
