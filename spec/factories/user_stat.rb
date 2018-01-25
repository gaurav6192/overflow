FactoryBot.define do
  factory :user_stat do
    full_name "Foo Bar"
    user_name "foobar"
    email "foo@bar.com"
    about "I come from Foo World."
    password "123456"
    password_confirmation "123456"
  end
end