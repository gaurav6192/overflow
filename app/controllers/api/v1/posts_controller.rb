module Api::V1
	class PostsController < ApiController

		def index
			# posts = Post.where(filtered_params)
			# render json: posts, status: :ok
			return render json: Tag.find(params[:tag_id]).posts.page(params[:page]).includes(:post_stat), include: :post_stat, status: :ok if params[:tag_id]
			return render json: User.find(params[:user_id]).posts.page(params[:page]).includes(:post_stat), include: :post_stat, status: :ok if params[:user_id]
			super
		end

		def show
			return render json: Tag.find(params[:tag_id]).find_post, include: :post_stat, status: :ok if params[:tag_id]
			return render json: User.find(params[:user_id]).find_post, include: :post_stat, status: :ok if params[:user_id]
			super
		end

		def create
			post = current_user.posts.create!(filtered_params)
			post_stat = PostStat.create(post: post, last_activity_date: DateTime.now)

			render json: post, include: :post_stat, status: :created
		end

		def update
			post = Post.find(params[:id])
			owner = User.find(post.user_id)

			if owner.id == current_user.id
				post.update_attributes!(filtered_params)
				post.revisions.where(user_id: current_user.id).create!(revisionable_content: { title: params[:title], body: params[:body] } )
			else
				post_edit = post.edits.new(editable_content: {
					title: params[:title],
					body: params[:body]
				})
				post_edit.user = current_user
				post_edit.save!
			end

			render json: post, status: :ok, include: :post_stat
		end

		def destroy
			post = current_user.posts.find(params[:id])
			post.destroy
			
			render json: {}, status: :no_content
		end

		private

			def filtered_params
				params.require(:post).permit(:title, :body, :user_id, :tag_ids)
			end

			def model
				Post
			end

			def find_post
				posts.find(params[:id])
			end
	end
end
