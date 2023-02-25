require 'rails_helper'

RSpec.describe 'Users API' do
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
      expect(existing_user[:data][:attributes].keys.sort).to eq([:sub, :username, :email, :name, :picture].sort)
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
    it 'destroys the user' do
      user = create(:user)

      delete "/api/v1/users/#{user.id}"

      expect(response).to be_successful
      expect(response.status).to eq(204)
      expect(User.count).to eq(0)
      expect(User.last).to eq(nil)
    end
  end
end
