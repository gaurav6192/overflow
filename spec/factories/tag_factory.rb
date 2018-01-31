FactoryBot.define do
  factory :tag do |f|
    sequence(:title) { |n| Faker::Team.unique.name << n.to_s }
  end
end
