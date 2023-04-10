require "rails_helper"

RSpec.describe Revibration, type: :model do
  it { should belong_to :user }
  it { should belong_to :vibration }
end
