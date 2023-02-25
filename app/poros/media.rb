class Media
  attr_reader :id,
              :title,
              :audience_score,
              :rating,
              :type,
              :description,
              :genres,
              :release_year,
              :runtime,
              :language,
              :streaming_services,
              :poster

  def initialize(media_data)
    @id                 = media_data[:id]
    @title              = media_data[:title]
    @audience_score     = media_data[:user_rating]
    @rating             = media_data[:us_rating]
    @type               = media_data[:type]
    @description        = media_data[:plot_overview]
    @genres             = media_data[:genre_names]
    @release_year       = media_data[:year]
    @runtime            = media_data[:runtime_minutes]
    @language           = media_data[:original_language]
    @streaming_services = media_data[:sources]
    @poster             = media_data[:poster]
  end

  def subscription_services
    # return ['Not Available For Streaming'] if streaming_services == []
    # this was an idea but doesn't seem to be appropriate to be handled by poros 
    # maybe should be done in view on FE
    services = streaming_services.select do |service|
      service[:type] == 'sub'
    end
    services.map do |service|
      service[:name]
    end
  end

  # make a method to find the streaming services wher type is 'sub' 
  # or 'free' maybe? 
end
