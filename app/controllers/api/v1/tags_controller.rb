module Api::V1
	class TagsController < ApiController
		def create
			render json: Tag.create!(filtered_params), status: :created
		end

		def update
			render json: Tag.find(params[:id]).update_attributes!(filtered_params), status: :ok
		end

		private

		def filtered_params
			params.require(:tag).permit(:title)
		end

		def model
			Tag
		end

		def find_tag
			tags.find(params[:id])
		end
	end
end