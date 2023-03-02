require 'rails_helper'

RSpec.describe 'Edit Media List API' do
  describe 'patch user/user_id/media/id?list=' do
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

  describe 'patch user/user_id/media/id?rating=' do
    it 'can update a rated usermedia rating that is on a users list' do
      user = create(:user) 
      list = user.lists.last
      user_media = create(:user_media, media_id: 3173903, user_rating: 1) 
      media_list = MediaList.create(list: list, user_media: user_media) 
      
      media_id = 3173903 
      patch "/api/v1/users/#{user.id}/media/#{media_id}/?rating=4"

      expect(response).to be_successful
      expect(response.status).to eq 204

      expect(user.user_medias.last.media_id).to eq 3173903
      expect(user.user_medias.last.user_rating).to eq 4
    end

    it 'can update an unrated usermedia rating that is on a users list' do
      user = create(:user) 
      list = user.lists.last
      user_media = create(:user_media, media_id: 3173903) 
      media_list = MediaList.create(list: list, user_media: user_media) 
      
      media_id = 3173903 
      patch "/api/v1/users/#{user.id}/media/#{media_id}/?rating=4"

      expect(response).to be_successful
      expect(response.status).to eq 204

      expect(user.user_medias.last.media_id).to eq 3173903
      expect(user.user_medias.last.user_rating).to eq 4
    end

    it 'can update a usermedia that is not yet on a users lists' do
      user = create(:user) 
      
      media_id = 3173903 
      patch "/api/v1/users/#{user.id}/media/#{media_id}/?rating=4"

      expect(response).to be_successful
      expect(response.status).to eq 204

      expect(user.user_medias.last.user_rating).to eq 4
      expect(user.watched.last.media_id).to eq 3173903
    end

    it 'raises an error if user_id is invalid' do
      media_id = 3173903 
      patch "/api/v1/users/asdf/media/#{media_id}/?rating=4"

      expect(response.status).to eq 404
    end

    it 'should raise a validation error if rating is greater than 5' do
      user = create(:user) 
      
      media_id = 3173903 
      patch "/api/v1/users/#{user.id}/media/#{media_id}/?rating=6"

      expect(response.status).to eq 400 

      expect(user.user_medias).to eq []
    end

    it 'should raise a validation error if rating is less than 0' do
      user = create(:user) 
      
      media_id = 3173903 
      patch "/api/v1/users/#{user.id}/media/#{media_id}/?rating=-6"

      expect(response.status).to eq 400 

      expect(user.user_medias).to eq []
    end

    it 'should raise a validation error if rating is not an integer' do
      user = create(:user) 
      
      media_id = 3173903 
      patch "/api/v1/users/#{user.id}/media/#{media_id}/?rating=3.3"

      expect(response.status).to eq 400 

      expect(user.user_medias).to eq []
    end

    it 'should raise a valildation error if rating is not a number' do
      user = create(:user) 
      
      media_id = 3173903 
      patch "/api/v1/users/#{user.id}/media/#{media_id}/?rating=asdf"

      expect(response.status).to eq 400 

      expect(user.user_medias).to eq []
    end
  end
end
