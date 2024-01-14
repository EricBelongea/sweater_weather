class Api::V0::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user  && user.authenticate(params[:password])
      render json: UserSerializer.new(user)
    else
      render json: { status: 400, error: "Sorry, Bad Credentials" }, status: :bad_request
    end
  end
end