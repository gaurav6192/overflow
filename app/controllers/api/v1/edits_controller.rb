module Api::V1
	class EditsController < ApiController

		def index
			return render json: Answer.find(params[:answer_id]).edits.page(params[:page]), status: :ok if params[:answer_id]
			return render json: Post.find(params[:post_id]).edits.page(params[:page]), status: :ok if params[:post_id]
			return render json: User.find(params[:user_id]).edits.page(params[:page]), status: :ok if params[:user_id]
			super
		end

		private

			def model
				Edit
			end
	end
end
