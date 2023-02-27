class TrendingMedia
  attr_reader :id,
              :title,
              :poster_path,
              :media_type,
              :vote_average

  def initialize(media_params)
    @id             = media_params[:id]
    @title          = media_params[:title]
    @poster_path    = media_params[:poster_path]
    @media_type     = media_params[:media_type]
    @vote_average   = media_params[:vote_average]
  end
end
