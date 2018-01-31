FactoryBot.define do
  factory :post_stat do
    score 1
    view_count 1
    last_activity_date DateTime.now
    
    post
  end
end
