FactoryBot.define do
  factory :post_vote, aliases: ['vote'], class: 'vote' do
    association :voteable, factory: :post_stat
    user_stat
    vote_type
  end

  factory :answer_vote, class: 'vote' do
    association :voteable, factory: :answer_stat
    user_stat
    vote_type
  end

  factory :edit_vote, class: 'vote' do
    association :voteable, factory: :edit_stat
    user_stat
    vote_type
  end
end
