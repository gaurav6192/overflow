module Api::V1
  class VoteTypesController < ApiController

    private
      def filtered_params
        params.require(:vote_type).permit(:name, :score_change)
      end

      def model
        VoteType
      end
  end
end
