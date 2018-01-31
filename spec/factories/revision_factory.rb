FactoryBot.define do
  factory :post_revision, aliases: ['revision'], class: 'revision' do
    revisionable_content "{ 'title: 'Revised title', 'body': 'This is a revised question.' }"
    
    association :revisionable, factory: :post
    edit
    user
  end

  factory :answer_revision, class: 'revision' do
    revisionable_content "{ 'body': 'This is a revised answer.' }"
    
    association :revisionable, factory: :answer
    edit
    user
  end

  factory :comment_revision, class: 'revision' do
    revisionable_content "{ 'content': 'This is a revised question.' }"
    
    association :revisionable, factory: :comment
    edit
    user
  end
end