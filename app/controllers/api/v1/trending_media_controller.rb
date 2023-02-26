class Api::V1::TrendingMediaController < ApplicationController

  def index
    top_3_media = TrendingMediaFacade.details
    render json: TrendingMediaSerializer.new(top_3_media)
  end
end