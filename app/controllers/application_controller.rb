class ApplicationController < ActionController::API

  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def login
    authenticate_with_http_basic do |email, password|
      user = User.find_by(email: email)
      if user && user.password == password
        render json: { token: user.auth_token , userId: user.id, userName: user.name}
      else
        render json: { error: 'Incorrect credentials' }, status: 401
      end
    end
  end

  before_action :authenticate_user_from_token, except: [:login]

  protected

  def authenticate_user_from_token
    unless authenticate_with_http_token { |token, options| User.find_by(auth_token: token) }
      render json: { error: 'Bad Token'}, status: 401
    end
  end
end
