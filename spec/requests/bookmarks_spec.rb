require "rails_helper"

RSpec.describe "Bookmarks", type: :request do
  let(:user) { create(:user) }
  let(:vibration) { create(:vibration) }

  before { sign_in user }

  describe "POST create" do
    it "creates a new Bookmark" do
      expect do
        post vibration_bookmarks_path(vibration)
      end.to change { Bookmark.count }.by(1)
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "DELETE destroy" do
    it "deletes a Bookmark" do
      bookmark = create(:bookmark, user: user, vibration: vibration)
      expect do
        delete vibration_bookmark_path(vibration, bookmark)
      end.to change { Bookmark.count }.by(-1)
      expect(response).to have_http_status(:redirect)
    end
  end
end
