require "rails_helper"

RSpec.describe "Vibrations", type: :request do
  describe "GET show" do
    let(:user) { create(:user) }
    let(:vibration) { create(:vibration) }

    before do
      sign_in user
      allow(ViewVibrationJob).to receive(:perform_later)
    end

    it "succeeds" do
      get vibration_path(vibration)
      expect(response).to have_http_status(:success)
    end

    it "queues up ViewedVibrationJob" do
      get vibration_path(vibration)
      expect(ViewVibrationJob).to have_received(:perform_later).with(user: user, vibration: vibration)
    end
  end

  describe "POST create" do
    context "when not signed in" do
      it "is responds with redirect" do
        post vibrations_path, params: {
          vibration: {
            body: "New vibration body"
          }
        }
        expect(response).to have_http_status(:redirect)
      end
    end

    context "when logged in" do
      let(:user) { create(:user) }
      before do
        sign_in user
        allow(VibrationActivity::VibrationedJob).to receive(:perform_later)
      end

      it "creates a new vibration" do
        expect do
          post vibrations_path, params: {
            vibration: {
              body: "New vibration body"
            }
          }
        end.to change { Vibration.count }.by(1)
        expect(response).to redirect_to(dashboard_path)
      end

      it "queues up VibrationActivity::VibrationedJob" do
        post vibrations_path, params: {
          vibration: {
            body: "New vibration body"
          }
        }
        vibration = Vibration.last
        expect(VibrationActivity::VibrationedJob).to have_received(:perform_later).with(actor: user, vibration: vibration)
      end
    end
  end
end
