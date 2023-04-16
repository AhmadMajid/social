require "rails_helper"

RSpec.describe Vibration, type: :model do
  it { should belong_to :user }
  it { should have_many(:likes).dependent(:destroy) }
  it { should have_many(:liked_users).through(:likes) }
  it { should have_many(:bookmarks).dependent(:destroy) }
  it { should have_many(:bookmarked_users).through(:bookmarks).source(:user) }
  it { should have_many(:revibrations).dependent(:destroy) }
  it { should have_many(:revibrationed_users).through(:revibrations).source(:user) }
  it { should have_many(:views).dependent(:destroy) }
  it { should have_many(:viewed_users).through(:views).source(:user) }
  it { should belong_to(:parent_vibration).with_foreign_key(:parent_vibration_id).class_name("Vibration").inverse_of(:reply_vibrations).optional }
  it { should have_many(:reply_vibrations).with_foreign_key(:parent_vibration_id).class_name("Vibration") }
  it { should have_and_belong_to_many(:hashtags) }
  it { should validate_presence_of(:body) }
  it { should validate_length_of(:body).is_at_most(280) }
end
