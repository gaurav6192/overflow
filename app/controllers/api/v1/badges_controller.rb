module Api::V1
	class BadgesController < ApiController

		private
			def filtered_params
				params.require(:badge).permit(:name, :about)
			end

			def model
				Badge
			end
	end
end