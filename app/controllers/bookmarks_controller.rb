class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def index
    @vibration_presenters = current_user.bookmarked_vibrations.map do |vibration|
      VibrationPresenter.new(vibration: vibration, current_user: current_user)
    end
  end

  def create
    @bookmark = current_user.bookmarks.create(vibration: vibration)
    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.turbo_stream
    end
  end

  def destroy
    @bookmark = vibration.bookmarks.find(params[:id])
    @bookmark.destroy
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
