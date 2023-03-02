class MediaFacade
  def self.details(id, user_id = nil)
      media_data = MediaService.details(id)
      Media.new(media_data, user_id) if media_data[:id]
  end

  def self.user_list_details(user_id, list_name)
    user = User.find(user_id)
    list_media_ids = user.media_ids_for(list_name)
    list_media_ids.map do |media_id|
      details(media_id, user_id)
    end
  end

  def self.search(query, user_id = nil)
    search_results = MediaService.search(query)
    search_results[:results].map do |media_data|
      Media.new(media_data, user_id)
    end
  end
end
