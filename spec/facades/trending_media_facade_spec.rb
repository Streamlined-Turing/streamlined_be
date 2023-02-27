require 'rails_helper'

RSpec.describe TrendingMediaFacade do 
  before(:each) do 
    stub_request(:get, "https://api.themoviedb.org/3/trending/all/day?api_key=#{ENV["moviedb_api_key"]}")
      .to_return(status: 200, body: File.read('spec/fixtures/top_trending_media.json'), headers: {})
  end

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