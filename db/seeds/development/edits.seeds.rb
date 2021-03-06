after "development:comments" do
	10.times do |n|
	  post  = Post.all.sample
	  user_id = User.pluck(:id).sample

	  title = Faker::Lorem.unique.sentence
	  body = Faker::Lorem.unique.paragraph

	  edit = post.edits.new({
	  	editable_content: { title:  title, body: body },
	  	user_id: user_id
  	})
  	edit.create_edit_stat
  	edit.save
	end

	12.times do |n|
	  answer  = Answer.all.sample
	  user_id = User.pluck(:id).sample

	  body = Faker::Lorem.unique.paragraph

	  edit = answer.edits.new({
	  	editable_content: { body: body },
	  	user_id: user_id
	  })
	  edit.create_edit_stat
  	edit.save
	end

	7.times do |n|
	  comment  = Comment.all.sample
	  user_id = comment.user_id

	  content = Faker::Lorem.unique.paragraph

	  edit = comment.edits.new({
	  	editable_content: { content: content },
	  	user_id: user_id
	  })
	  edit.create_edit_stat
  	edit.save
	end
end