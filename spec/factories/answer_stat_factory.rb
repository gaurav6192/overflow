FactoryBot.define do
  factory :answer_stat do
    score 1
    view_count 1
    last_activity_date DateTime.now
    
    answer
  end
end
