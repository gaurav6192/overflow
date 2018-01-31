FactoryBot.define do
  factory :upvote, aliases: ['vote_type'], class: 'vote_type' do
    name "Upvote"
    score_change 1
  end

  factory :downvote, class: 'vote_type' do
    name "Downvote"
    score_change -1
  end

  factory :super, class: 'vote_type' do
    name "Super5"
    score_change 5
  end
end
