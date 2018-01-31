FactoryBot.define do
  factory :post do |f|
    f.title Faker::Lorem.unique.sentence
    f.body Faker::Lorem.paragraph
    
    user

    after(:create) do |post|
      create :post_stat, post: post
    end

    trait :with_answers do |f|
    	transient do
        answers_count 5
      end

      after(:create) do |post, evaluator|
        create_list :answer, evaluator.answers_count, post: post
      end
    end
  end
end