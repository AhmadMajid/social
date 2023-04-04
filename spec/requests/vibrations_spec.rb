require "rails_helper"

RSpec.describe "Vibrations", type: :request do
  describe "POST create" do
    context "when not signed in" do
      it "is responds with redirect" do
        post vibrations_path, params: {
          vibrations: {
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
