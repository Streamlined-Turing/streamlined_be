class Api::V1::MediaDetailsController < ApplicationController 

  def show 
    media = MediaFacade.details(params[:id])
    render json: MediaSerializer.new(media), status: :ok
  end
end
