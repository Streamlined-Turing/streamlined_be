class TrendingMediaFacade 

  def self.details
    media = TrendingMediaService.details 
    media = media[:results].select do |media|
      media[:media_type] == 'movie' || 'tv'
    end
    media[0..2].map do |media|
      TrendingMedia.new(media)
    end
  end
end