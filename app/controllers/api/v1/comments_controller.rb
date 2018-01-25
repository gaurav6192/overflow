module Api::V1
	class CommentsController < ApiController

		def index
			return render json: Answer.find(params[:answer_id]).comments.page(params[:page]).includes(:comment_stat), include: :comment_stat, status: :ok if params[:answer_id]
			return render json: Post.find(params[:post_id]).comments.page(params[:page]).includes(:comment_stat), include: :comment_stat, status: :ok if params[:post_id]
			return render json: User.find(params[:user_id]).comments.page(params[:page]).includes(:comment_stat), include: :comment_stat, status: :ok if params[:user_id]
			super
		end

		def create
			comment = Answer.find(params[:answer_id]).comments.where(user_id: current_user.id).create!(filtered_params) if params[:answer_id]
			comment = Post.find(params[:post_id]).comments.where(user_id: current_user.id).create!(filtered_params) if params[:post_id]
			
			comment_stat = CommentStat.create(comment: comment)

			comment.revisions.where(user_id: current_user.id).create!(revisionable_content: { content: params[:content] } )

			render json: comment, include: :comment_stat, status: :created
		end

		def update
			comment = Post.find(params[:answer_id]).comments.find(params[:id]) if params[:answer_id]
			comment = Post.find(params[:post_id]).comments.find(params[:id]) if params[:post_id]
			owner = User.find(comment.user_id)

			if owner.id == current_user.id
				comment.update_attributes!(filtered_params)
				comment.revisions.where(user_id: current_user.id).create!(revisionable_content: { content: params[:content] } )
			else
				return render json: comment, status: :forbidden, include: :comment_stat
			end

			render json: comment, status: :ok, include: :comment_stat
		end

		def destroy
			comment = Answer.find(params[:answer_id]).comments.where(user_id: current_user.id).find(params[:id]) if params[:answer_id]
			comment = Post.find(params[:post_id]).comments.where(user_id: current_user.id).find(params[:id]) if params[:post_id]
			comment.destroy
			
			render json: {}, status: :no_content
		end

		private

			def filtered_params
				params.require(:comment).permit(:content)
			end

			def model
				Comment
			end

			def find_comment
				comments.find(params[:id])
			end
	end
end
