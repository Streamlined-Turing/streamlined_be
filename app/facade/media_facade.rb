class MediaFacade
  def self.details(id)
    media_data = MediaService.details(id)
    Media.new(media_data) if media_data[:id]
  end

  def self.search(query)
    search_results = MediaService.search(query)
    search_results[:results].map do |media_data|
      Media.new(media_data)
    end
  end
end
