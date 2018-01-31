FactoryBot.define do
  fake_name = Faker::Name.name

  factory :user do |f|
    f.full_name fake_name
    sequence(:user_name) { |n| fake_name.gsub(/\s+/, "")[0...20] << n.to_s }
    sequence(:email) { |n| "example-#{n+1}@railstutorial.org" }
    f.password "password"
    f.password_confirmation "password"

    # badges { [create(:badge)] }
    # tags { [create(:tag)] }
    
    after(:create) do |user|
      create :user_stat, user: user
    end
  end
end