require 'rails_helper'

RSpec.describe 'User Lists API' do
  describe 'Show a users lists' do
    it 'show a users currently watching list' do
      stub_request(:get, "https://api.watchmode.com/v1/title/3173903/details?apiKey=#{ENV['watch_mode_api_key']}&append_to_response=sources")
      .to_return(status: 200, body: File.read('spec/fixtures/breaking_bad_details_3173903.json'), headers: {})
      
      stub_request(:get, "https://api.watchmode.com/v1/title/345534/details?apiKey=#{ENV['watch_mode_api_key']}&append_to_response=sources")
      .to_return(status: 200, body: File.read('spec/fixtures/game_of_thrones_details_345534.json'), headers: {})

      stub_request(:get, "https://api.watchmode.com/v1/title/1402919/details?apiKey=#{ENV['watch_mode_api_key']}&append_to_response=sources")
      .to_return(status: 200, body: File.read('spec/fixtures/lego_batman_details_1402919.json'), headers: {})

      user = create(:user)
      currently_watching_list = user.lists.find_by("name ILIKE ?", "currently watching")
      want_to_watch_list = user.lists.find_by("name ILIKE ?", "want to watch")
      game_of_thrones = create(:user_media, media_id: 345534)
      breaking_bad = create(:user_media, media_id: 3173903)
      lego_batman = create(:user_media, media_id: 1402919)
      MediaList.create(list: want_to_watch_list, user_media: breaking_bad)
      MediaList.create(list: currently_watching_list, user_media: game_of_thrones)
      MediaList.create(list: currently_watching_list, user_media: lego_batman)
      
      query = 'currently watching'
      get "/api/v1/users/#{user.id}/lists?list=#{query}"
      list_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(list_data).to be_a Hash
      expect(list_data).to have_key(:data)
      expect(list_data[:data]).to be_an(Array)
      expect(list_data[:data].length).to eq(2)

      list_data[:data].each do |media|
        expect(media).to include(:id, :type, :attributes)
        expect(media[:id]).to be_a(String)
        expect(media[:type]).to be_a(String)
        expect(media[:attributes]).to be_a(Hash)
        
        attributes = media[:attributes]
        expect(attributes).to include(
                                        :id, 
                                        :title, 
                                        :audience_score, 
                                        :rating, 
                                        :media_type, 
                                        :description,
                                        :genres,
                                        :release_year,
                                        :runtime,
                                        :language,
                                        :sub_services,
                                        :poster,
                                        :imdb_id,
                                        :tmdb_id,
                                        :tmdb_type,
                                        :trailer
                                      )
        expect(attributes[:id]).to be_a(Integer)
        expect(attributes[:title]).to be_a(String)
        expect(attributes[:audience_score]).to be_a(Float)
        expect(attributes[:rating]).to be_a(String)
        expect(attributes[:media_type]).to be_a(String)
        expect(attributes[:description]).to be_a(String)
        expect(attributes[:genres]).to be_a(Array)
        expect(attributes[:release_year]).to be_a(Integer)
        expect(attributes[:runtime]).to be_a(Integer)
        expect(attributes[:language]).to be_a(String)
        expect(attributes[:sub_services]).to be_a(Array)
        expect(attributes[:poster]).to be_a(String)
        expect(attributes[:imdb_id]).to be_a(String)
        expect(attributes[:tmdb_id]).to be_a(Integer)
        expect(attributes[:tmdb_type]).to be_a(String)
        expect(attributes[:trailer]).to be_a(String)
      end
    end

    it 'returns error if list name does not match any of the users lists' do
      user = create(:user)
      query = 'fake list'
      get "/api/v1/users/#{user.id}/lists?list=#{query}"
      expect(response).to have_http_status(:not_found)
  
      error_json = JSON.parse(response.body, symbolize_names:true)
      expect(error_json[:errors].first[:detail]).to eq("Couldn't find List with the name: 'fake list'")
    end

    it 'returns error if user does not exist' do
      query = 'currently watching'
      user_id = '12346134613461234'
      get "/api/v1/users/#{user_id}/lists?list=#{query}"
      expect(response).to have_http_status(:not_found)
      error_json = JSON.parse(response.body, symbolize_names:true)
      expect(error_json[:errors].first[:detail]).to eq("Couldn't find User with 'id'=12346134613461234")
    end
  end
end