require 'rails_helper'

RSpec.describe 'Users API', :vcr do
  describe 'create a user resource' do
    it 'can create a new user in the database' do
      user_params = {
        'sub' => '104505147435508023263',
        'name' => 'Alex Pitzel',
        'username' => 'pitzelalex',
        'email' => 'pitzelalex@gmail.com',
        'first_name' => 'Alex',
        'last_name' => 'Pitzel',
        'picture' => 'https://lh3.googleusercontent.com/a/AEdFTp5vj_rzxJzWHjgqM1-InqDI0fJWxwpHK_zElpKLgA=s96-c'
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

      new_user = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(new_user.size).to eq(1)
      expect(new_user).to have_key(:data)
      expect(new_user[:data]).to be_a(Hash)
      expect(new_user[:data]).to have_key(:id)
      expect(new_user[:data]).to have_key(:type)
      expect(new_user[:data]).to have_key(:attributes)
      expect(new_user[:data][:attributes]).to have_key(:sub)
      expect(new_user[:data][:attributes]).to have_key(:username)
      expect(new_user[:data][:attributes]).to have_key(:email)
      expect(new_user[:data][:attributes]).to have_key(:name)
      expect(new_user[:data][:attributes]).to have_key(:picture)
      expect(new_user[:data][:attributes]).to_not have_key(:first_name)
      expect(new_user[:data][:attributes]).to_not have_key(:last_name)
    end

    it 'returns an existing user from the database' do
      user = create(:user)

      user_params = {
        'sub' => user.sub,
        'username' => user.username,
        'email' => user.email,
        'name' => user.name,
        'picture' => user.picture
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

      existing_user = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(existing_user[:data]).to be_a(Hash)
      expect(existing_user[:data]).to have_key(:type)
      expect(existing_user[:data]).to have_key(:attributes)
      expect(existing_user[:data][:id].to_i).to eq(user.id)
      expect(existing_user[:data][:attributes].keys.sort).to eq(%i[sub username email name picture].sort)
      expect(existing_user[:data][:attributes][:sub]).to eq(user.sub)
      expect(existing_user[:data][:attributes][:username]).to eq(user.username)
      expect(existing_user[:data][:attributes][:email]).to eq(user.email)
      expect(existing_user[:data][:attributes][:name]).to eq(user.name)
      expect(existing_user[:data][:attributes][:picture]).to eq(user.picture)
    end
  end

  describe 'edit a user resource' do
    it 'can update user attributes' do
      user = User.create!(sub: '104505147435508023263',
                          email: 'johnny@example.com',
                          name: 'Johnny Appleseed',
                          picture: 'https://lh3.googleusercontent.com/a/AEdFTp5vj_rzxJzWHjgqM1-InqDI0fJWxwpHK_zElpKLgA=s96-c')

      expect(user.username).to be nil

      update_params = { 'username' => 'mr-apples' }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      patch "/api/v1/users/#{user.id}", headers: headers, params: JSON.generate(update_params)

      updated_user = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(User.find(user.id).username).to eq('mr-apples')
    end

    it 'cannot enter invalid characters' do
      user = User.create!(sub: '104505147435508023263',
                          email: 'johnny@example.com',
                          name: 'Johnny Appleseed',
                          picture: 'https://lh3.googleusercontent.com/a/AEdFTp5vj_rzxJzWHjgqM1-InqDI0fJWxwpHK_zElpKLgA=s96-c')

      expect(user.username).to be nil

      update_params = { 'username' => 'mr-apples()' }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      patch "/api/v1/users/#{user.id}", headers: headers, params: JSON.generate(update_params)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(error[:message]).to eq('Invalid characters. Only - and _ allowed for special characters')

      update_params = { 'username' => 'mr-apples& $' }
      patch "/api/v1/users/#{user.id}", headers: headers, params: JSON.generate(update_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
    end

    it 'username must be of a certain length' do
      user = User.create!(sub: '104505147435508023263',
                          email: 'johnny@example.com',
                          name: 'Johnny Appleseed',
                          picture: 'https://lh3.googleusercontent.com/a/AEdFTp5vj_rzxJzWHjgqM1-InqDI0fJWxwpHK_zElpKLgA=s96-c')

      expect(user.username).to be nil

      update_params = { 'username' => 'a' }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      patch "/api/v1/users/#{user.id}", headers: headers, params: JSON.generate(update_params)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(error[:message]).to eq('Username must be 6 - 36 characters in length')

      update_params = { 'username' => 'supercalafragalisticexpialadociousisnotlongenoughitneedsmorecharacters' }
      patch "/api/v1/users/#{user.id}", headers: headers, params: JSON.generate(update_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
    end

    it 'returns a valid error if both are criteria fail' do
      user = User.create!(sub: '104505147435508023263',
                          email: 'johnny@example.com',
                          name: 'Johnny Appleseed',
                          picture: 'https://lh3.googleusercontent.com/a/AEdFTp5vj_rzxJzWHjgqM1-InqDI0fJWxwpHK_zElpKLgA=s96-c')

      expect(user.username).to be nil

      update_params = { 'username' => 'a[]' }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      patch "/api/v1/users/#{user.id}", headers: headers, params: JSON.generate(update_params)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(error[:message]).to eq('Invalid characters. Only - and _ allowed for special characters, Username must be 6 - 36 characters in length')
    end
  end

  describe 'show a user resource' do
    it 'can show a user by users id' do
      user = User.create!(username: 'Johnny',
                          sub: '104505147435508023263',
                          email: 'johnny@example.com',
                          name: 'Johnny Appleseed',
                          picture: 'https://lh3.googleusercontent.com/a/AEdFTp5vj_rzxJzWHjgqM1-InqDI0fJWxwpHK_zElpKLgA=s96-c')

      get "/api/v1/users/#{user.id}"

      user_result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(user_result.size).to eq(1)
      expect(user_result).to have_key(:data)
      expect(user_result[:data]).to be_a(Hash)
      expect(user_result[:data]).to have_key(:id)
      expect(user_result[:data][:id]).to eq(user.id.to_s)
      expect(user_result[:data]).to have_key(:type)
      expect(user_result[:data][:type]).to eq('user')
      expect(user_result[:data]).to have_key(:attributes)
      expect(user_result[:data][:attributes]).to be_a(Hash)
      expect(user_result[:data][:attributes]).to have_key(:sub)
      expect(user_result[:data][:attributes][:sub]).to eq('104505147435508023263')
      expect(user_result[:data][:attributes]).to have_key(:username)
      expect(user_result[:data][:attributes][:username]).to eq('Johnny')
      expect(user_result[:data][:attributes]).to have_key(:email)
      expect(user_result[:data][:attributes][:email]).to eq('johnny@example.com')
      expect(user_result[:data][:attributes]).to have_key(:name)
      expect(user_result[:data][:attributes][:name]).to eq('Johnny Appleseed')
      expect(user_result[:data][:attributes]).to_not have_key(:last_name)
      expect(user_result[:data][:attributes]).to have_key(:picture)
      expect(user_result[:data][:attributes][:picture]).to eq('https://lh3.googleusercontent.com/a/AEdFTp5vj_rzxJzWHjgqM1-InqDI0fJWxwpHK_zElpKLgA=s96-c')
    end
  end

  describe 'deleting a user' do
    it 'destroys the user and all associated resources' do
      user = create(:user)
      want_to_watch = user.lists.create(name: 'want to watch')
      currently_watching = user.lists.create(name: 'currently watching')
      watched = user.lists.create(name: 'watched')
      user_media1 = UserMedia.create(media_id: 1, user_rating: nil, user_review: '')
      user_media2 = UserMedia.create(media_id: 2, user_rating: nil, user_review: '')
      user_media3 = UserMedia.create(media_id: 3, user_rating: 1, user_review: 'DNF')
      media_list1 = want_to_watch.media_lists.create(user_media_id: user_media1.id)
      media_list2 = currently_watching.media_lists.create(user_media_id: user_media2.id)
      media_list3 = watched.media_lists.create(user_media_id: user_media3.id)

      delete "/api/v1/users/#{user.id}"

      expect(response).to be_successful
      expect(response.status).to eq(204)
      expect(User.all).to eq([])
      expect(List.all).to eq([])
      expect(UserMedia.all).to eq([])
      expect(MediaList.all).to eq([])
    end

    it 'returns an error when a user that does not exist is deleted' do
      delete '/api/v1/users/1'

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(result[:message]).to eq('User with id 1 not found')
    end
  end
end
