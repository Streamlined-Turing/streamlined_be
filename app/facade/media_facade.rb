class MediaFacade
  def self.details(id)
    media_data = MediaService.details(id)
    if media_data[:id] 
      Media.new(media_data) 
    else
      nil
    end
  end
end
