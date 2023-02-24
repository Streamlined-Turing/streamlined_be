class Api::V1::UsersController < ApplicationController
  def create
    if (user = User.find_by(uid: params[:uid]))
      user
      render json: UserSerializer.new(user), status: :ok
    else
      user = User.create(user_params)
      render json: UserSerializer.new(user), status: :created
    end
  end

  def update
    user = User.find(params[:id])
    user.update(username: params[:username])
    render json: UserSerializer.new(user), status: :ok
  end

  def show
    render json: UserSerializer.new(User.find(params[:id])), status: 200
  end

  private

  def user_params
    params.permit(:username,
                  :uid,
                  :full_name,
                  :email,
                  :image)
  end
end
