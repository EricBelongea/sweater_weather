class Api::V0::UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      render json: UserSerializer.new(user), status: :created
    else
      render json: { error: user.errors.full_messages }, status: :bad_request
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end