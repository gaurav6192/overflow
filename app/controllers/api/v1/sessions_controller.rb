module Api::V1
	class SessionsController < ApiController
		skip_before_action :authorize, only: :create

	  def create
	  	return render json: { error: { message: 'Already logged in' } }, status: :forbidden if is_logged_in?
	  	user = User.find_by(email: filtered_params[:email].downcase)
	  	user_auth = AuthHandler.new(user)
  		session = Session.create!(user: user_auth.authenticate(session_params[:password], cookies), auth_token: cookies.signed[:auth_token])
  		render json: user, status: :ok
	  end

	  def destroy
	  	user_auth = AuthHandler.new
	    user_auth.session_destroy(find_session, cookies)
	    render json: {}, status: :ok
	  end

	  private

  	def filtered_params
	    params.require(:user).permit(:email, :password)
	  end

	  def find_session
	    Session.find_by(auth_token: cookies.signed[:auth_token])
	  end

	  def is_logged_in?
	    cookies.signed[:auth_token] && find_session
	  end
	end
end
