after "development:users" do
	10.times do |n|
	  title  = Faker::Team.unique.name << n.to_s
	  user_ids = User.all.pluck(:id).sample(rand(1..5))
	  Tag.create!(
	  	title:  title,
	  	user_ids: user_ids
	  )
	end
end