FactoryBot.define do
  factory :badge do
    sequence(:name) { |n| Faker::Beer.unique.hop << n.to_s }
  end
end
