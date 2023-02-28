require 'rails_helper'

RSpec.describe MediaService, :vcr do
  before(:each) do
    @breaking_bad_id = 3173903

    @query = 'everything'
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

        expected_keys = [:name, :relevance, :type, :id, :year, :result_type, :tmdb_id, :tmdb_type, :image_url]
        expect(response.keys).to eq([:results])
        expect(response[:results]).to be_a Array
        response[:results].each do |result|
          expect(result.keys.sort).to eq(expected_keys.sort)
        end
      end
    end
  end
end
