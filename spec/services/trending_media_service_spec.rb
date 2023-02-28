require 'rails_helper'

RSpec.describe TrendingMediaService, :vcr do

  describe '.details' do
    it 'returns a response with all trending media details' do
      response = TrendingMediaService.details

      expect(response[:results][0]).to have_key(:id)
      expect(response[:results][0]).to have_key(:title)
      expect(response[:results][0]).to have_key(:poster_path)
      expect(response[:results][0]).to have_key(:media_type)
      expect(response[:results][0]).to have_key(:vote_average)
    end
  end
end
