class Api::V1::UsersController < ApplicationController 
  def create
    user = User.find_or_create_by(user_params)
    render json: UserSerializer.new(user), status: 200
  end

  def show 
    render json: UserSerializer.new(User.find(params[:id])), status: 200
  end

  private 

  def user_params
    params.require(:user).permit(:username, 
                                 :uid, 
                                 :first_name, 
                                 :last_name,
                                 :email,
                                 :image)
  end
end