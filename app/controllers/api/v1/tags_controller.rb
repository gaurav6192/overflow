module Api::V1
	class TagsController < ApiController
		def create
			render json: current_user.tags.create!(filtered_params), status: :created
		end

		def update
			render json: current_user.find_tag.update_attributes!(filtered_params), status: :ok
		end

		private

		def filtered_params
			params.require(:badge).permit(:title)
		end

		def model
			Tag
		end

		def find_tag
			tags.find(params[:id])
		end
	end