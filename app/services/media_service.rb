class MediaService
  def self.details(id)
    response = conn.get("/v1/title/#{id}/details", { append_to_response: 'sources' })
    parse_json(response)
  end

  def self.search(query)
    response = conn.get('/v1/search/', { search_field: 'name', search_value: query, types: 'tv,movie' })
    parse_json(response)
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn
    Faraday.new(url: 'https://api.watchmode.com', params: { apiKey: ENV['watch_mode_api_key'] })
  end
end
