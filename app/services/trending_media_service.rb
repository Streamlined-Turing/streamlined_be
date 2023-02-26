class TrendingMediaService 

  def self.details
    response = conn.get("/trending/all/day")
    JSON.parse(response.body, symbolize_names: true)
  end

  private 

  def self.conn 
    Faraday.new(url: "https://api.themoviedb.org/3", params: { api_key: ENV['moviedb_api_key']})
  end
end