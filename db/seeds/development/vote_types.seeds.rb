after "development:comments" do
	votes = [
		{ name: "Upvote", score_change: 1 },
		{ name: "Downvote", score_change: -1 }
	]
	
	votes.each do |vote|
	  VoteType.create!(
	  	name:  vote[:name],
	  	score_change: vote[:score_change]
	  )
	end
end