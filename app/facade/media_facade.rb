class MediaFacade
  def self.details(id)
    media_data = MediaService.details(id)
    Media.new(media_data)
  end
end
