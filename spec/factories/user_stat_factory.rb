FactoryBot.define do
  factory :user_stat do
    reputation_count 0
    last_voted_at DateTime.now
    last_reputation_changed_at DateTime.now

    user
  end
end