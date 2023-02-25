require 'rails_helper'

RSpec.describe MediaService do
  before(:each) do
    @breaking_bad_id = 3173903
    stub_request(:get, "https://api.watchmode.com/v1/title/3173903/details?apiKey=#{ENV['watch_mode_api_key']}&append_to_response=sources")
      .to_return(status: 200, body: File.read('spec/fixtures/breaking_bad_details_3173903.json'), headers: {})
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
  end
end
