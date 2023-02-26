require 'rails_helper'

RSpec.describe 'Watchmode API' do
  describe 'get media/id' do
    it 'sends media details' do
      stub_request(:get, "https://api.watchmode.com/v1/title/3173903/details?apiKey=#{ENV['watch_mode_api_key']}&append_to_response=sources")
        .to_return(status: 200, body: File.read('spec/fixtures/breaking_bad_details_3173903.json'), headers: {})

      expected_keys = [:id, :title, :audience_score, :rating, :media_type, :description, :genres, :release_year,
                       :runtime, :language, :sub_services, :poster_path, :trailer, :imdb_id, :tmdb_id, :tmdb_type]

      show_id = 3173903
      get "/api/v1/media/#{show_id}"

      media_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(media_data).to be_a Hash
      expect(media_data.keys).to eq([:data])
      expect(media_data[:data]).to be_a Hash
      expect(media_data[:data].keys.sort).to eq([:type, :id, :attributes].sort)
      expect(media_data[:data][:id]).to be_a String
      expect(media_data[:data][:type]).to eq('media')
      expect(media_data[:data][:attributes]).to be_a Hash
      expect(media_data[:data][:attributes].keys.sort).to eq(expected_keys.sort)
      expect(media_data[:data][:attributes][:id]).to be_an Integer
      expect(media_data[:data][:attributes][:title]).to be_a String
      expect(media_data[:data][:attributes][:audience_score]).to be_a Float
      expect(media_data[:data][:attributes][:rating]).to be_a String
      expect(media_data[:data][:attributes][:media_type]).to be_a String
      expect(media_data[:data][:attributes][:description]).to be_a String
      expect(media_data[:data][:attributes][:genres]).to be_an Array
      expect(media_data[:data][:attributes][:release_year]).to be_an Integer
      expect(media_data[:data][:attributes][:runtime]).to be_an Integer
      expect(media_data[:data][:attributes][:language]).to be_a String
      expect(media_data[:data][:attributes][:sub_services]).to be_an Array
      media_data[:data][:attributes][:sub_services].each do |service|
        expect(service).to be_a String
      end
      expect(media_data[:data][:attributes][:poster_path]).to be_a String
      expect(media_data[:data][:attributes][:trailer]).to be_a String
      expect(media_data[:data][:attributes][:imdb_id]).to be_a String
      expect(media_data[:data][:attributes][:tmdb_id]).to be_a Integer
      expect(media_data[:data][:attributes][:tmdb_type]).to be_a String
    end

    it 'returns an error message when an incorrect id is passed' do
      stub_request(:get, "https://api.watchmode.com/v1/title/show_id/details?apiKey=#{ENV['watch_mode_api_key']}&append_to_response=sources")
        .to_return(status: 404, body: File.read('spec/fixtures/media_details_404.json'), headers: {})

      show_id = 3173903
      get '/api/v1/media/show_id'

      media_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(media_data).to eq({
                                 success: false,
                                 statusCode: 404,
                                 statusMessage: 'The resource could not be found.'
                               })
    end
  end

  describe 'get media?q=' do
    it 'returns an array of media with title matching query param' do
      query = 'everything'
      stub_request(:get, "https://api.watchmode.com/v1/autocomplete-search/?search_field=name&search_value=#{query}&search_type=2&apiKey=#{ENV['watch_mode_api_key']}")
        .to_return(status: 200, body: File.read('spec/fixtures/media_search_everything.json'), headers: {})

      expected_keys = [:id, :title, :media_type, :release_year, :tmdb_id, :tmdb_type, :poster_path]

      get "/api/v1/media?q=#{query}"

      search_result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(search_result).to be_a Hash
      expect(search_result[:data]).to be_a Array
      search_result[:data].first(15).each do |media_data|
        expect(media_data).to be_a Hash
        expect(media_data.keys.sort).to eq([:id, :type, :attributes].sort)
        expect(media_data[:id]).to be_a String
        expect(media_data[:type]).to eq('search_result')
        expect(media_data[:attributes]).to be_a Hash
        expect(media_data[:attributes].keys.sort).to eq(expected_keys.sort)
        expect(media_data[:attributes][:id]).to be_a Integer
        expect(media_data[:attributes][:title]).to be_a String
        expect(media_data[:attributes][:media_type]).to be_a String
        expect(media_data[:attributes][:release_year]).to be_a Integer
        expect(media_data[:attributes][:tmdb_id]).to be_a Integer
        expect(media_data[:attributes][:tmdb_type]).to be_a String
        expect(media_data[:attributes][:poster_path]).to be_a String
      end
    end

    it 'returns hash with data and an empty array if no matches for query' do
      query = 'tyranorsauriouesbadfasdfg'
      stub_request(:get, "https://api.watchmode.com/v1/autocomplete-search/?search_field=name&search_value=#{query}&search_type=2&apiKey=#{ENV['watch_mode_api_key']}")
        .to_return(status: 200, body: File.read('spec/fixtures/search_no_results.json'), headers: {})

      get "/api/v1/media?q=#{query}"
      no_result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(no_result).to eq({ :data => [] })
    end
  end
end
