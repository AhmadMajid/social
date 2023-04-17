
require "rails_helper"

RSpec.describe Mention, type: :model do
  it { should belong_to :vibration }
  it { should belong_to(:mentioned_user).class_name("User") }
end
