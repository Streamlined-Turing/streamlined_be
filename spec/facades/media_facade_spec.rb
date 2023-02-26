require 'rails_helper'

RSpec.describe MediaFacade do
  before(:each) do
    @breaking_bad_id = 3173903
    stub_request(:get, "https://api.watchmode.com/v1/title/3173903/details?apiKey=#{ENV['watch_mode_api_key']}&append_to_response=sources")
      .to_return(status: 200, body: File.read('spec/fixtures/breaking_bad_details_3173903.json'), headers: {})

    @query = 'everything'
    stub_request(:get, "https://api.watchmode.com/v1/autocomplete-search/?search_field=name&search_value=#{@query}&search_type=2&apiKey=#{ENV['watch_mode_api_key']}")
      .to_return(status: 200, body: File.read('spec/fixtures/media_search_everything.json'), headers: {})
  end

  describe '.details' do
    it 'returns a media details object' do
      media_details = MediaFacade.details(@breaking_bad_id)

      expect(media_details).to be_a Media
      expect(media_details.id).to eq(@breaking_bad_id)
    end
  end

  describe '.search' do
    it 'returns an array of media objects' do
      search_results = MediaFacade.search(@query)

      search_results.each do |result|
        expect(result).to be_a Media
      end
    end
  end
end
