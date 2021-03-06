class UsersController < ApplicationController
  # before signup we don't need a token, only require user credentials
  skip_before_action :authorize_request, only: :create
  # POST /signup
  # return authenticated token upon signup
  def create
    # We use create! so that if the event there's and error, an exception will
    # be raised and handled in the exception handler
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
