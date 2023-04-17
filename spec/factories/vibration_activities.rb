FactoryBot.define do
  factory :vibration_activity do
    user
    vibration
    verb { VibrationActivity::VERBS.sample }
  end
end
