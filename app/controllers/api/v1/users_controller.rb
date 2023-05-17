class Api::V1::UsersController < ApplicationController
  def create
    if (user = User.find_by(sub: params[:sub]))
      render json: UserSerializer.new(user), status: :ok
    else
      user = User.create(user_params)
      render json: UserSerializer.new(user), status: :created
      # WelcomeSenderJob.perform_async(user.email, user.name)
      # TODO: figure out how to use sidekiq/redis to do the thang async
    end
  end

  def update
    @errors = []
    if verified_username?
      user = User.find(params[:id])
      user.update(username: params[:username])
      render json: UserSerializer.new(user), status: :ok
    else
      render json: { message: @errors.join(', ') }, status: 400
    end
  end

  def show
    render json: UserSerializer.new(User.find(params[:id])), status: 200
  end

  def destroy
    begin
      User.destroy(params[:id])
      render status: :no_content
    rescue StandardError => e
      render json: { message: "User with id #{params[:id]} not found" }, status: 404
    end
  end

  private

  def user_params
    params.permit(:username,
                  :sub,
                  :name,
                  :email,
                  :picture)
  end

  def verify_characters
    if params[:username] == params[:username].gsub(/[^0-9A-Za-z_-]/, '')
      true
    else
      @errors << 'Invalid characters. Only - and _ allowed for special characters'
      false
    end
  end

  def verify_length
    if params[:username].length >= 6 && params[:username].length <= 36
      true
    else
      @errors << 'Username must be 6 - 36 characters in length'
      false
    end
  end

  def verified_username?
    verify_characters & verify_length
  end
end
