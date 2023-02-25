class Api::V1::MediaController < ApplicationController
  def show
    media = MediaFacade.details(params[:id])
    if media
      render json: MediaSerializer.new(media), status: :ok
    else
      error = {
        success: false,
        statusCode: 404,
        statusMessage: 'The resource could not be found.'
      }
      render json: error, status: :not_found
    end
  end
end
