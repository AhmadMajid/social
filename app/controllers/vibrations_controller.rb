class VibrationsController < ApplicationController
  def create
    vibration = Vibration.new(vibration_params.merge(user: current_user))

    if vibration.save
      redirect_to root_path
    end
  end

  private

  def vibration_params
    params.require(:vibration).permit(:body)
  end
end
