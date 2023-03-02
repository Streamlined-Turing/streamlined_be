require 'rails_helper'

RSpec.describe 'Users Media List API' do
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

  describe 'delete user_media/id' do
    it 'deletes user_media for a user' do
      user = create(:user) 
      list_name = 'currently watching'
      list = user.lists.find_by("name ILIKE ?", list_name)
      user_media = create(:user_media, media_id: 3173903) 
      media_list = MediaList.create(list: list, user_media: user_media)

      expect(user.currently_watching).to eq([user_media])
      expect(MediaList.find_by(list: list)).to eq(media_list)

      delete "/api/v1/users/#{user.id}/media/#{user_media.media_id}"
      
      expect(response).to be_successful
      expect(response.status).to eq 204
      
      expect(MediaList.find_by(list: list)).to be nil
      expect(user.currently_watching).to eq([])
    end

    it 'only deletes the user media off the list of a single user' do
      list_name = 'currently watching'
      breaking_bad_id = 3173903

      user1 = create(:user) 
      user1_list = user1.lists.find_by("name ILIKE ?", list_name)
      user1_media = create(:user_media, media_id: breaking_bad_id) 
      media_list1 = MediaList.create(list: user1_list, user_media: user1_media)

      user2 = create(:user) 
      user2_list = user2.lists.find_by("name ILIKE ?", list_name)
      user2_media = create(:user_media, media_id: breaking_bad_id) 
      media_list2 = MediaList.create(list: user2_list, user_media: user2_media)

      expect(user1.currently_watching).to eq([user1_media])
      expect(user2.currently_watching).to eq([user2_media])
      expect(user1_media.media_id).to eq(user2_media.media_id)

      delete "/api/v1/users/#{user1.id}/media/#{breaking_bad_id}"

      expect(user1.currently_watching).to eq([])
      expect(user2.currently_watching).to eq([user2_media])
    end

    it 'returns an error if the user cannot be found' do
      list_name = 'currently watching'
      breaking_bad_id = 3173903
      
      user1 = create(:user) 
      user1_list = user1.lists.find_by("name ILIKE ?", list_name)
      user1_media = create(:user_media, media_id: breaking_bad_id) 
      media_list1 = MediaList.create(list: user1_list, user_media: user1_media)
      not_real_user_id = User.last.id+1

      delete "/api/v1/users/#{not_real_user_id}/media/#{breaking_bad_id}"

      expect(response).to_not be_successful
      expect(response.status).to eq 404
      error_json = JSON.parse(response.body, symbolize_names:true)
      expect(error_json[:errors].first[:detail]).to eq("Couldn't find User with 'id'=#{not_real_user_id}")
    end

    it 'returns an error if trying to delete media a user doesnt have' do
      breaking_bad_id = 3173903
      
      user1 = create(:user) 

      expect(user1.user_medias).to be_empty

      delete "/api/v1/users/#{user1.id}/media/#{breaking_bad_id}"
      expect(response).to_not be_successful
      expect(response.status).to eq 404
      error_json = JSON.parse(response.body, symbolize_names:true)
      expect(error_json[:errors].first[:detail]).to eq("Couldn't find UserMedia with the id: '3173903'")
    end
  end
end
