module Api::V1
	class UsersController < ApiController
		# skip_before_action :authorize, only: :create
		before_action :check_session, only: :create
		before_action :correct_user, only: [:edit, :update, :destroy]

		def index
			return render json: Badge.find(params[:badge_id]).users.page(params[:page]).includes(:user_stat), include: :user_stat, status: :ok if params[:badge_id]
			super
		end

		def show
			return render json: Badge.find(params[:badge_id]).find_user, include: :user_stat, status: :ok if params[:badge_id]
			super
		end

		def create
			user = User.create!(filtered_params)
			user_stat = UserStat.create(user: user)

			render json: user, include: :user_stat, status: :created
		end

		def update
			user = User.find(params[:id])
			user.update_attributes!(filtered_params)

			render json: user, status: :ok, include: :user_stat
		end

		private
			
		def filtered_params
			params.require(:user).permit([:email, :full_name, :user_name, :password, :password_confirmation])
		end

		def model
			User
		end

		def find_user
			users.find(params[:id])
		end

		def correct_user
			user = User.find(params[:id])
			render json: { error: { message: 'Forbidden' } }, status: :forbidden unless current_user.id == user.id
		end

		def check_session
	    render json: { error: { message: 'Already logged in' } }, status: :forbidden if current_session.present?
	  end
	end
end