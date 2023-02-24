require 'rails_helper'

RSpec.describe 'Watchmode API' do 
  describe 'media details request' do 
    it 'receives media details' do 
      get "/api/v1/media_details/tv-1399"

      expect(response).to be_successful
    end
  end
end