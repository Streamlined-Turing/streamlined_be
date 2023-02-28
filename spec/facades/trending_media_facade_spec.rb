require 'rails_helper'

RSpec.describe TrendingMediaFacade, :vcr do
  describe '.details' do
    it 'returns an array of 3 trending media objects' do
      media_array = TrendingMediaFacade.details

      expect(media_array.count).to eq(3)
      media_array.each do |media|
        expect(media).to be_a TrendingMedia
      end
    end
  end
end
