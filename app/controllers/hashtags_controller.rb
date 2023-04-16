class HashtagsController < ApplicationController
  before_action :authenticate_user!

  def index
    @hashtags = Hashtag.includes(:vibrations)
  end

  def show
    @hashtag = Hashtag.find(params[:id])
    @vibration_presenters = @hashtag.vibrations.order(created_at: :desc).map do |vibration|
      VibrationPresenter.new(vibration: vibration, current_user: current_user)
    end
  end
end
