FactoryBot.define do
  factory :answer do
  	body Faker::Lorem.paragraph
    
    post
    user
  end

  trait :with_stat do
    after(:create) do |answer|
      create :answer_stat, answer: answer
    end
  end
end
