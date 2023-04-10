class VibrationsController < ApplicationController
  before_action :authenticate_user!

  def show
    create_view_record unless View.exists?(user: current_user, vibration: vibration)
    @vibration_presenter = VibrationPresenter.new(vibration: vibration, current_user: current_user)
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

  def create_view_record
    View.create(vibration: vibration, user: current_user)
  end
end
