require "rails_helper"

RSpec.describe "Likes", type: :request do
  let(:user) { create(:user) }
  let(:vibration) { create(:vibration) }

  before { sign_in user }

  describe "POST create" do
    it "creates a new like" do
      expect do
        post vibration_likes_path(vibration)
      end.to change { Like.count }.by(1)
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "DELETE destroy" do
    it "deletes a like" do
      like = create(:like, user: user, vibration: vibration)
      expect do
        delete vibration_like_path(vibration, like)
      end.to change { Like.count }.by(-1)
      expect(response).to have_http_status(:redirect)
    end
  end
end
