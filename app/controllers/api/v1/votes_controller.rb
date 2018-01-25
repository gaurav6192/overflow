module Api::V1
	class VotesController < ApiController
		def index
			return render json: Answer.find(params[:answer_id]).votes.page(params[:page]), status: :ok if params[:answer_id]
			return render json: Post.find(params[:post_id]).votes.page(params[:page]), status: :ok if params[:post_id]
			return render json: User.find(params[:user_id]).votes.page(params[:page]), status: :ok if params[:user_id]
			return render json: VoteType.find(params[:vote_type_id]).votes.page(params[:page]), status: :ok if params[:vote_type_id]
			super
		end

		def create
			vote_type = VoteType.find(params[:vote_type_id])
			vote = Post.find(params[:post_id]).answers.where(user_id: current_user.id).create!(filtered_params)
			answer_stat = AnswerStat.create(answer: answer, last_activity_date: DateTime.now)

			answer.revisions.where(user_id: current_user.id).create!(revisionable_content: { body: params[:body] } )

			render json: answer, include: :answer_stat, status: :created
		end

		def update
			answer = Post.find(params[:post_id]).answers.find(params[:id])
			owner = User.find(answer.user_id)

			if owner.id == current_user.id
				answer.update_attributes!(filtered_params)
				answer.revisions.where(user_id: current_user.id).create!(revisionable_content: { body: params[:body] } )
			else
				answer_edit = answer.edits.new(filtered_params)
				answer_edit.user = current_user
				answer_edit.save!
			end

			render json: answer, status: :ok, include: :answer_stat
		end

		def destroy
			answer = Post.find(params[:post_id]).answers.where(user_id: current_user.id).find(params[:id])
			answer.destroy
			
			render json: {}, status: :no_content
		end

		private

		def filtered_params
			params.require(:vote).permit(:body)
		end

		def model
			Vote
		end

		def find_answer
			votes.find(params[:id])
		end
	end
end
