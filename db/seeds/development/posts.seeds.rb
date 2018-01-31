after "development:tags" do
	100.times do |n|
	  title  = Faker::Lorem.unique.sentence
	  body  = Faker::Lorem.unique.paragraph
	  user_id = User.all.pluck(:id).sample
	  tag_ids = Tag.all.pluck(:id).sample(rand(1..3))
	  post = Post.new(
	  	title:  title,
	  	body: body,
	  	user_id: user_id,
	  	tag_ids: tag_ids
	  )
	  post.create_post_stat
		post.save
	end
end