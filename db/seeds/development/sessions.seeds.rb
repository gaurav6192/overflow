after "development:users" do
	5.times do
	  user = User.all.sample
	  Session.create(user: user, auth_token: SecureRandom.urlsafe_base64)
	end
end