require "rails_helper"

RSpec.describe VibrationActivity::VibrationedJob, type: :job do
  let(:user) { create(:user) }
  let(:vibration) { create(:vibration) }
  let(:vibration_user) { vibration.user }

  it "creates a new vibration" do
    vibration_user.followers << user
    expect do
      described_class.new.perform(actor: vibration_user, vibration: vibration)
    end.to change { VibrationActivity.count }.by(1)
  end
end
