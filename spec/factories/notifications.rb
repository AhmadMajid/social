FactoryBot.define do
  factory :notification do
    user
    actor { create(:user) }
    vibration
    verb { Notification::VERBS.sample }
  end
end
