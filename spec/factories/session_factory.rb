FactoryBot.define do
  factory :session do |f|
    f.auth_token SecureRandom.urlsafe_base64
    
    user
  end
end
