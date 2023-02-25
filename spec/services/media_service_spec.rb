require 'rails_helper'

RSpec.describe MediaService do
  before(:each) do
    @breaking_bad_id = 3173903
    stub_request(:get, "https://api.watchmode.com/v1/title/#{@breaking_bad_id}/details?apiKey=#{ENV['watch_mode_api_key']}&append_to_response=sources")
      .to_return(status: 200, body: File.read('spec/fixtures/breaking_bad_details_3173903.json'), headers: {})
    
    @query = 'everything'
    stub_request(:get, "https://api.watchmode.com/v1/search/?search_field=name&search_value=#{@query}&types=tv,movie&apiKey=#{ENV['watch_mode_api_key']}")
      .to_return(status: 200, body: File.read('spec/fixtures/media_search_everything.json'), headers: {})
  end

  describe '.details' do
    it 'returns a response with the medias details' do
      response = MediaService.details(@breaking_bad_id)

      expect(response).to have_key(:id)
      expect(response).to have_key(:title)
      expect(response).to have_key(:user_rating)
      expect(response).to have_key(:us_rating)
      expect(response).to have_key(:type)
      expect(response).to have_key(:plot_overview)
      expect(response).to have_key(:genre_names)
      expect(response).to have_key(:year)
      expect(response).to have_key(:runtime_minutes)
      expect(response).to have_key(:original_language)
      expect(response).to have_key(:sources)
      expect(response).to have_key(:poster)
    end

    describe '.search' do
      it 'returns an array of results matching query' do
        response = MediaService.search(@query)

        expected_keys = [:resultType, :id, :name, :type, :year, :imdb_id, :tmdb_id, :tmdb_type]
        expect(response).to have_key(:people_results)
        expect(response[:people_results]).to eq([])
        expect(response).to have_key(:title_results)
        response[:title_results].each do |result|
          expect(result.keys.sort).to eq(expected_keys.sort)
        end
      end
    end
  end
end
