FactoryBot.define do
  factory :notification do
    user { nil }
    actor { nil }
    vibration { nil }
    verb { "MyString" }
  end
end
