require 'rails_helper'

RSpec.describe 'Edit Media List API' do
  describe 'patch user_media/id' do
    it 'changes or creates a media_list entry to link a usermedia to a list' do
      user_data = {
        username: 'test',
        sub: '1',
        email: 'test@test',
        name: 'ant o',
        picture: 'picture_path'
      }
      user = User.create!(user_data) 

      stub_request(:patch, "https://localhost:5000/api/v1/users/1/media/1")
        .to_return(status: 200, body: File.read('spec/fixtures/usermedia/media1.json'))

      media_id = 3173903 
      patch "/api/v1/users/#{user.id}/media/#{media_id}/?list=Watched"

      media_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to 204

      expect(user.currently_watching).to eq []
    end
  end
end
