require "rails_helper"

RSpec.describe "ReplyVibrations", type: :request do
  let(:user) { create(:user) }
  let(:parent_vibration) { create(:vibration) }

  before { sign_in user }

  describe "POST create" do
    before { parent_vibration }

    it "creates a new vibration" do
      expect do
        post vibration_reply_vibrations_path(parent_vibration), params: {
          vibration: {
            body: "New vibration body"
          }
        }
      end.to change { Vibration.count }.by(1)
      expect(response).to redirect_to(dashboard_path)
    end

    it "creates a new VibrationActivity" do
      expect do
        post vibration_reply_vibrations_path(parent_vibration), params: {
          vibration: {
            body: "New vibration body"
          }
        }
      end.to change { VibrationActivity.count }.by(1)
    end
  end
end
