require "rails_helper"

RSpec.describe ViewVibrationJob, type: :job do
  let(:user) { create(:user) }
  let(:vibration) { create(:vibration) }

  subject do
    described_class.new.perform(vibration: vibration, user: user)
  end

  it "creates a view record when vibration has not been viewed" do
    expect { subject }.to change { View.count }.by(1)
  end

  it "does not create a view record when vibration has already been viewed" do
    create(:view, user: user, vibration: vibration)
    expect { subject }.not_to change { View.count }
  end
end
