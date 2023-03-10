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
              :poster,
              :imdb_id,
              :tmdb_id,
              :tmdb_type,
              :trailer,
              :user_lists,
              :user_rating,
              :added_to_list_on

  def initialize(media_data, user_id = nil)
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
    @poster             = media_data[:poster] || media_data[:image_url]
    @imdb_id            = media_data[:imdb_id]
    @tmdb_id            = media_data[:tmdb_id]
    @tmdb_type          = media_data[:tmdb_type]
    @trailer            = media_data[:trailer]
    @user_lists         = lists(user_id)
    @added_to_list_on    = media_list_updated_at(user_id)
    @user_rating        = set_rating(user_id)
    @sub_services       = subscription_services
  end

  def subscription_services
    return [] unless @streaming_services

    services = @streaming_services.select do |service|
      service[:type] == 'sub'
    end
    services.map { |service| service[:name] }
  end

  private

  def lists(user_id)
    user = User.find_by(id: user_id)
    if user
      user.user_medias.where(media_id: self.id).take.try(:list).try(:name) || 'None'
    else
      'None'
    end
  end

  def set_rating(user_id)
    user = User.find_by(id: user_id)
    if user
      user.user_medias.where(media_id: self.id).take.try(:user_rating)
    end
  end

  def media_list_updated_at(user_id)
    user = User.find_by(id: user_id)
    if user
      user.user_medias.where(media_id: self.id).take.try(:media_list).try(:updated_at)
    end
  end
end
