FactoryBot.define do
  factory :post_edit, aliases: ['edit'], class: 'edit' do
    score 1
    editable_content "{ 'title: 'Edited title', 'body': 'This is an edited question.' }"
    
    association :editable, factory: :post
    user

    after(:create) do |edit|
      create :edit_stat, edit: edit
    end
  end

  factory :answer_edit, class: 'edit' do
    score 1
    editable_content "{ 'body': 'This is an edited answer.' }"
    
    association :editable, factory: :answer
    user

    after(:create) do |edit|
      create :edit_stat, edit: edit
    end
  end

  factory :comment_edit, class: 'edit' do
    score 1
    editable_content "{ 'content': 'This is an edited question.' }"
    
    association :editable, factory: :comment
    user

    after(:create) do |edit|
      create :edit_stat, edit: edit
    end
  end

  trait :revised do
    after :create do |edit|
      create :revision, edit: edit
    end
  end
end