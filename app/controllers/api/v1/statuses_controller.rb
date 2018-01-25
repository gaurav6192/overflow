module Api::V1
	class StatusesController < ApiController

		private

			def filtered_params
				params.require(:status).permit(:name)
			end

			def model
				Status
			end
	end
end
