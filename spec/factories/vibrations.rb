FactoryBot.define do
  factory :vibration do
    user
    body { Faker::Lorem.paragraph }
  end
end
