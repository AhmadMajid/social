require "rails_helper"

RSpec.describe User, type: :model do
  it { should have_many(:vibrations).dependent(:destroy) }
  it { should have_many(:likes).dependent(:destroy) }
  it { should have_many(:liked_vibrations).through(:likes).source(:vibration) }
  it { should have_many(:bookmarks).dependent(:destroy) }
  it { should have_many(:bookmarked_vibrations).through(:bookmarks).source(:vibration) }
  it { should have_many(:revibrations).dependent(:destroy) }
  it { should have_many(:revibrationed_vibrations).through(:revibrations).source(:vibration) }
  it { should have_many(:views) }
  it { should have_many(:viewed_vibrations).through(:views).source(:vibration) }
  it { should have_many(:followings).dependent(:destroy) }
  it { should have_many(:following_users).through(:followings) }
  it { should have_many(:reverse_followings).with_foreign_key(:following_user_id).class_name("Following") }
  it { should have_many(:followers).through(:reverse_followings).source(:user) }
  it { should have_and_belong_to_many :message_threads }
  it { should have_many(:messages) }
  it { should have_many(:notifications).dependent(:destroy) }

  it { should validate_uniqueness_of(:username).case_insensitive.allow_blank }

  describe "#set_display_name" do
    context "when display_name is set" do
      it "does not change the display_name" do
        user = build(:user, username: "cjeon", display_name: "Chris Jeon")
        user.save
        expect(user.reload.display_name).to eq("Chris Jeon")
      end
    end

    context "when display_name is not set" do
      it "humanizes the previously set username" do
        user = build(:user, username: "cjeon", display_name: nil)
        user.save
        expect(user.reload.display_name).to eq("Cjeon")
      end
    end
  end
end
