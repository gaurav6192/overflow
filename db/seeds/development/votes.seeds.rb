after "development:vote_types" do
	1000.times do |n|
	  vote_type_id  = VoteType.pluck(:id).sample
	  user_id = User.pluck(:id).sample
	  user_stat = UserStat.find_by(user_id: user_id)
	  
	  post = Post.all.sample

	  vote = post.post_stat.votes.create!(
	  	vote_type_id:  vote_type_id,
	  	user_stat_id: user_stat.id
	  )

	  post.post_stat.update_attributes(score: post.post_stat.score + vote.vote_type.score_change, last_activity_date: DateTime.now)
	  user_stat.update_attributes(last_voted_at: DateTime.now)
	end

	1000.times do |n|
	  vote_type_id  = VoteType.pluck(:id).sample
	  user_id = User.pluck(:id).sample
	  user_stat = UserStat.find_by(user_id: user_id)
	  
	  answer = Answer.all.sample

	  vote = answer.answer_stat.votes.create!(
	  	vote_type_id:  vote_type_id,
	  	user_stat_id: user_stat.id
	  )

	  answer.answer_stat.update_attributes(score: answer.answer_stat.score + vote.vote_type.score_change, last_activity_date: DateTime.now)
	  user_stat.update_attributes(last_voted_at: DateTime.now)
	end

	2000.times do |n|
	  vote_type_id  = VoteType.pluck(:id).sample
	  user_id = User.pluck(:id).sample
	  user_stat = UserStat.find_by(user_id: user_id)
	  
	  edit = Edit.all.sample

	  vote = edit.edit_stat.votes.create!(
	  	vote_type_id:  vote_type_id,
	  	user_stat_id: user_stat.id
	  )

	  edit.edit_stat.update_attributes(score: edit.edit_stat.score + vote.vote_type.score_change, last_activity_date: DateTime.now)
	  user_stat.update_attributes(last_voted_at: DateTime.now)

	  if edit.edit_stat.score > 25 && !edit.revision.present?
	  	editable = edit.editable_type.constantize.find(edit.editable_id)
	  	editable.revisions.create!(
		  	editable_content: edit.editable_content,
		  	user_id: user_id,
		  	edit_id: edit.id
		  )
	  end
	end	
end