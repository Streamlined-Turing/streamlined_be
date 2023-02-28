class Api::V1::Users::ListsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    if user.has_list_name?(params[:list])
      list = MediaFacade.user_list_details(params[:user_id], params[:list])  
      render json: MediaSerializer.new(list), status: :ok
    else
      raise ActiveRecord::RecordNotFound.new "Couldn't find List with the name: '#{params[:list]}'"
    end
  end
end