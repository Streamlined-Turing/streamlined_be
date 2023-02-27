require 'rails_helper' 

RSpec.describe 'MovieDB API' do 
  describe 'trending media details request' do 
    it 'receives the days top 3 trending media details' do 
      stub_request(:get, "https://api.themoviedb.org/3/trending/all/day?api_key=#{ENV["moviedb_api_key"]}")
        .to_return(status: 200, body: File.read('spec/fixtures/top_trending_media.json'), headers: {})

      get "/api/v1/trending_media"

      media_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(media_data).to be_a Hash
      expect(media_data.keys).to eq([:data])
      expect(media_data[:data]).to be_an Array
      expect(media_data[:data].count).to eq(3)
      expect(media_data[:data][0]).to have_key(:attributes)
      expect(media_data[:data][0][:attributes]).to have_key(:id)
      expect(media_data[:data][0][:attributes][:id]).to be_a Integer
      expect(media_data[:data][0][:attributes]).to have_key(:title)
      expect(media_data[:data][0][:attributes][:title]).to be_a String
      expect(media_data[:data][0][:attributes]).to have_key(:poster_path)
      expect(media_data[:data][0][:attributes][:poster_path]).to be_a String
      expect(media_data[:data][0][:attributes]).to have_key(:media_type)
      expect(media_data[:data][0][:attributes][:media_type]).to be_a String
      expect(media_data[:data][0][:attributes]).to have_key(:vote_average)
      expect(media_data[:data][0][:attributes][:vote_average]).to be_a Float
      expect(media_data[:data][0][:attributes]).to_not have_key(:overview)
    end
  end
end