module Api::V1
	class VotesController < ApiController
		def index
			return render json: Answer.find(params[:answer_id]).answer_stat.votes.page(params[:page]), status: :ok if params[:answer_id]
			return render json: Post.find(params[:post_id]).post_stat.votes.page(params[:page]), status: :ok if params[:post_id]
			return render json: Post.find(params[:edit_id]).edit_stat.votes.page(params[:page]), status: :ok if params[:edit_id]
			return render json: User.find(params[:user_id]).user_stat.votes.page(params[:page]), status: :ok if params[:user_id]
			return render json: VoteType.find(params[:vote_type_id]).votes.page(params[:page]), status: :ok if params[:vote_type_id]
			super
		end

		def create
		  user_stat = current_user.user_stat
			vote_type = VoteType.find(params[:vote][:vote_type_id])
			
			stat = find_stat
			vote = stat.votes.where(user_stat_id: user_stat.id).create!(filtered_params)
			
			stat.update_attributes!(score: stat.score + vote_type.score_change, last_activity_date: DateTime.now)

			user_stat.update_attributes!(last_voted_at: DateTime.now)
			
			if params[:edit_id] && stat.score > 25 && !find_model.revision.present?
				edit = find_model
				editable = edit.editable_type.constantize.find(edit.editable_id)
		  	editable.revisions.create!(
			  	editable_content: edit.editable_content,
			  	user_id: user_id,
			  	edit_id: edit.id
			  )
			end

			render json: vote, status: :created
		end

		def destroy
			user_stat = current_user.user_stat
			stat = find_stat
			vote = stat.votes.where(user_stat_id: user_stat.id).find(params[:id])
			vote_type = vote.vote_type
			vote.destroy!

			stat.update_attributes!(score: stat.score - vote_type.score_change, last_activity_date: DateTime.now)
			user_stat.update_attributes!(last_voted_at: DateTime.now)
			
			render json: {}, status: :no_content
		end

		private

		def filtered_params
			params.require(:vote).permit(:vote_type_id)
		end

		def model
			Vote
		end

		def find_model
			if params[:answer_id]
				Answer.find(params[:answer_id])
			elsif params[:post_id]
				Post.find(params[:post_id])
			else
				Edit.find(params[:edit_id])
			end
		end

		def find_stat
			if params[:answer_id]
				Answer.find(params[:answer_id]).answer_stat
			elsif params[:post_id]
				Post.find(params[:post_id]).post_stat
			else
				Edit.find(params[:edit_id]).edit_stat
			end
		end
	end
end
