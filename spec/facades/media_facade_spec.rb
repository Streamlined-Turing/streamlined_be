require 'rails_helper'

RSpec.describe MediaFacade, :vcr do
  before(:each) do
    @breaking_bad_id = 3173903
    @query = 'everything'
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
