require "rails_helper"

RSpec.describe "Vibrations", type: :request do
  describe "GET show" do
    let(:user) { create(:user) }
    let(:vibration) { create(:vibration) }

    before { sign_in user }

    it "succeeds" do
      get vibration_path(vibration)
      expect(response).to have_http_status(:success)
    end

    it "increments the view count if the vibration has not been viewed" do
      expect { get vibration_path(vibration) }.to change { View.count }.by(1)
    end

    it "does not increment the view count if the vibration already has been viewed" do
      create(:view, user: user, vibration: vibration)
      expect { get vibration_path(vibration) }.not_to change { View.count }
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
      it "creates a new vibration" do
        user = create(:user)
        sign_in user
        expect do
          post vibrations_path, params: {
            vibration: {
              body: "New vibration body"
            }
          }
        end.to change { Vibration.count }.by(1)
        expect(response).to redirect_to(dashboard_path)
      end
    end
  end
end
