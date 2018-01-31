FactoryBot.define do
  factory :post_comment, aliases: ['comment'], class: 'Comment' do
    content "This is a question's comment."
    
    association :commentable, factory: :post
    user

    after(:create) do |comment|
      create :comment_stat, comment: comment
    end
  end

  factory :answer_comment, class: 'Comment' do
    content "This is an answer's comment."
    
    association :commentable, factory: :answer
    user

    after(:create) do |comment|
      create :comment_stat, comment: comment
    end
  end
end
