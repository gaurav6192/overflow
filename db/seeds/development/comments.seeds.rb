after "development:answers" do
	100.times do |n|
	  content  = Faker::Lorem.unique.paragraph
	  user_id = User.all.pluck(:id).sample
	  post = Post.all.sample
	  comment = post.comments.new(
	  	content: content,
	  	user_id: user_id
	  )
	  comment.create_comment_stat
		comment.save
	end

	100.times do |n|
	  content  = Faker::Lorem.unique.paragraph
	  user_id = User.all.pluck(:id).sample
	  answer = Answer.all.sample
	  comment = answer.comments.new(
	  	content: content,
	  	user_id: user_id
	  )
	  comment.create_comment_stat
		comment.save
	end
end