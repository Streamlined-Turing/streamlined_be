class Api::V1::UsersController < ApplicationController 
  def create
    # we'll need to do this instead of find_or_create 
    # to account for possibility that user changed any email profile settings

    if user = User.find_by(uid: params[:uid]) 
      user
    else
      user = User.create(user_params)
    end
    render json: UserSerializer.new(user), status: 200
  end

  def show 
    render json: UserSerializer.new(User.find(params[:id])), status: 200
  end

  private 

  def user_params
    # changed this to align with what FE is sending, will require further changes based on 
    # what oauth sends us
    params.permit(:username, 
                  :uid, 
                  :full_name, 
                  :email,
                  :image)
  end
end
