after "development:posts" do
	100.times do |n|
	  body  = Faker::Lorem.unique.paragraph
	  user_id = User.all.pluck(:id).sample
	  post_id = Post.all.pluck(:id).sample
	  answer = Answer.new(
	  	body: body,
	  	user_id: user_id,
	  	post_id: post_id
	  )
	  answer.create_answer_stat
		answer.save
	end
end