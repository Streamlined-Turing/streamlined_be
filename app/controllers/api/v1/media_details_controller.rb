class Api::V1::MediaDetailsController < ApplicationController 

  def show 
    # require 'pry'; binding.pry
    media = MediaFacade.details(params[:id])
    render json: MediaSerializer.new(media), status: :ok
  end
end
