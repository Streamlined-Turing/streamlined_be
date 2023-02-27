require 'rails_helper'

RSpec.describe TrendingMediaService do 
  before(:each) do 
    stub_request(:get, "https://api.themoviedb.org/3/trending/all/day?api_key=#{ENV["moviedb_api_key"]}")
      .to_return(status: 200, body: File.read('spec/fixtures/top_trending_media.json'), headers: {})
  end

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