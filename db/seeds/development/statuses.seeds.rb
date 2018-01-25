# after "development:users" do
	10.times do |n|
	  user_id = User.all.pluck(:id).sample
	  name  = Faker::Color.unique.color_name
	  Status.create!(
	  	name:  name,
	  	user_id:  user_id
	  )
	end
# end