require "rails_helper"

RSpec.describe "Revibrations", type: :request do
  let(:user) { create(:user) }
  let(:vibration) { create(:vibration) }

  before { sign_in user }

  describe "POST create" do
    it "creates a new revibration" do
      expect do
        post vibration_revibrations_path(vibration)
      end.to change { Revibration.count }.by(1)
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "DELETE destroy" do
    it "deletes a revibration" do
      revibration = create(:revibration, user: user, vibration: vibration)
      expect do
        delete vibration_revibration_path(vibration, revibration)
      end.to change { Revibration.count }.by(-1)
      expect(response).to have_http_status(:redirect)
    end
  end
end
