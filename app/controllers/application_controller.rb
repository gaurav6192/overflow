class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  # before_action :authorize, except: [:login, :show, :index]

  def current_session
    @current_session ||= Session.find_by(auth_token: cookies.signed[:auth_token])
  end

  def current_user
    @current_user ||= current_session.try(:user)
  end

  def authorize
    render json: { error: { message: 'Unauthorized' } }, status: :unauthorized unless current_user
  end
end
