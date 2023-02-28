require 'rails_helper'

RSpec.describe 'Edit Media List API' do
  describe 'patch user_media/id' do
    it 'changes or creates a media_list entry to link a usermedia to a list' do
      user = create(:user) 
      list = user.lists.last
      user_media = create(:user_media, media_id: 3173903) 
      media_list = MediaList.create(list: list, user_media: user_media) 

      media_id = 3173903 
      patch "/api/v1/users/#{user.id}/media/#{media_id}/?list=Want to Watch"

      expect(response).to be_successful
      expect(response.status).to eq 204

      expect(user.want_to_watch).to eq [user_media]
    end

    it 'can add a new piece of media to a user list' do
      user = create(:user) 

      media_id = 3173903 
      patch "/api/v1/users/#{user.id}/media/#{media_id}/?list=Want to Watch"

      expect(response).to be_successful
      expect(response.status).to eq 204

      expect(user.want_to_watch).to eq [user.user_medias.last]
      expect(user.user_medias.last.list.name).to eq "Want to Watch"
    end
  end
end
