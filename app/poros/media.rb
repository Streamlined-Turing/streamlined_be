class Media
  attr_reader :id,
              :title,
              :audience_score,
              :rating,
              :media_type,
              :description,
              :genres,
              :release_year,
              :runtime,
              :language,
              :sub_services,
              :poster_path,
              :imdb_id,
              :tmdb_id,
              :tmdb_type,
              :trailer

  def initialize(media_data)
    @id                 = media_data[:id]
    @title              = media_data[:title] || media_data[:name]
    @audience_score     = media_data[:user_rating]
    @rating             = media_data[:us_rating]
    @media_type         = media_data[:type]
    @description        = media_data[:plot_overview]
    @genres             = media_data[:genre_names]
    @release_year       = media_data[:year]
    @runtime            = media_data[:runtime_minutes]
    @language           = media_data[:original_language]
    @streaming_services = media_data[:sources]
    @poster_path        = media_data[:poster] || media_data[:image_url]
    @imdb_id            = media_data[:imdb_id]
    @tmdb_id            = media_data[:tmdb_id]
    @tmdb_type          = media_data[:tmdb_type]
    @trailer            = media_data[:trailer]
    @sub_services       = subscription_services
  end

  def subscription_services
    return [] unless @streaming_services

    services = @streaming_services.select do |service|
      service[:type] == 'sub'
    end
    services.map { |service| service[:name] }
  end
end
