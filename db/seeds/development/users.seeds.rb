after "development:badges" do
	badge_ids = Badge.all.pluck(:id).sample(rand(5))

	user = User.new(
		full_name:  "Gaurav Verma",
		user_name:  "gaurav",
		email: "vermagaurav.gv@gmail.com",
		password: "password",
		password_confirmation: "password",
		badge_ids: badge_ids
	)
	user.create_user_stat
	user.save

	99.times do |n|
		badge_ids = Badge.all.pluck(:id).sample(rand(5))
	  
	  name  = Faker::Name.name
	  email = "example-#{n+1}@railstutorial.org"
	  password = "password"
	  user = User.new(
	  	full_name:  name,
	  	user_name:  name.gsub(/\s+/, "")[0...20],
	  	email: email,
	  	password: password,
	  	password_confirmation: password,
	  	badge_ids: badge_ids
		)
		user.create_user_stat
		user.save
	end
end