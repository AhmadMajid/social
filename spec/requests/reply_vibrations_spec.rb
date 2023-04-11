require "rails_helper"

RSpec.describe "ReplyVibrations", type: :request do
  describe "POST create" do
    it "creates a new vibration" do
      user = create(:user)
      parent_vibration = create(:vibration)
      sign_in user
      expect do
        post vibration_reply_vibrations_path(parent_vibration), params: {
          vibration: {
            body: "New vibration body"
          }
        }
      end.to change { Vibration.count }.by(1)
      expect(response).to redirect_to(dashboard_path)
    end
  end
end
