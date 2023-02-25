class MediaService
  def self.details(id)
    response = conn.get("/v1/title/#{id}/details")
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn
    Faraday.new(url: 'https://api.watchmode.com', params: { apiKey: ENV['watch_mode_api_key'] })
  end
end
