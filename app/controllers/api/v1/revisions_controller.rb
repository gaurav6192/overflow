module Api::V1
	class RevisionsController < ApiController

		def index
			return render json: Answer.find(params[:answer_id]).revisions.page(params[:page]), status: :ok 
			return render json: Post.find(params[:post_id]).revisions.page(params[:page]), status: :ok if params[:post_id]
			return render json: Answer.find(params[:answer_id]).comments.find(params[:comment_id]).revisions.page(params[:page]), status: :ok if params[:answer_id] && params[:comment_id]
			return render json: Post.find(params[:post_id]).comments.find(params[:comment_id]).revisions.page(params[:page]), status: :ok if params[:post_id] && params[:comment_id]
			super
		end

		private

			def model
				Revision
			end
	end
end
