require 'rails_helper'

RSpec.describe 'Users API' do 
  describe 'create a user resource' do 
    it 'can create a new user in the database' do 
      user_params = {
        "uid"=>"104505147435508023263",
        "full_name"=>"Alex Pitzel",
        "username"=>"pitzelalex",
        "email"=>"pitzelalex@gmail.com",
        "first_name"=>"Alex",
        "last_name"=>"Pitzel",
        "image"=>"https://lh3.googleusercontent.com/a/AEdFTp5vj_rzxJzWHjgqM1-InqDI0fJWxwpHK_zElpKLgA=s96-c"
      }
      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)

      new_user = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(new_user.size).to eq(1)
      expect(new_user).to have_key(:data)
      expect(new_user[:data]).to be_a(Hash)
      expect(new_user[:data]).to have_key(:id)
      expect(new_user[:data]).to have_key(:type)
      expect(new_user[:data]).to have_key(:attributes)
      expect(new_user[:data][:attributes]).to have_key(:uid)
      expect(new_user[:data][:attributes]).to have_key(:username)
      expect(new_user[:data][:attributes]).to have_key(:email)
      expect(new_user[:data][:attributes]).to have_key(:full_name)
      expect(new_user[:data][:attributes]).to have_key(:image)
      expect(new_user[:data][:attributes]).to_not have_key(:first_name)
      expect(new_user[:data][:attributes]).to_not have_key(:last_name)
    end

    it 'returns an existing user from the database' do 
      user = create(:user)

      user_params = {
        "uid"=> user.uid,
        "username"=>user.username,
        "email"=>user.email,
        "first_name"=>user.full_name,
        "image"=>user.image
      }

      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/users", headers: headers, params: JSON.generate(user: user_params)
      
      existing_user = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(existing_user[:data][:id].to_i).to eq(user.id)

    end

    xit 'returns an error is the user is not created and do not exist' do 

    end
  end

  describe 'show a user resource' do 
    it 'can show a user by users id' do 
      user = User.create!(username: "Johnny",
                          uid: "104505147435508023263",
                          email: "johnny@example.com",
                          full_name: "Johnny Appleseed",
                          image: "https://lh3.googleusercontent.com/a/AEdFTp5vj_rzxJzWHjgqM1-InqDI0fJWxwpHK_zElpKLgA=s96-c"
                         )

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
      expect(user_result[:data][:type]).to eq("user")
      expect(user_result[:data]).to have_key(:attributes)
      expect(user_result[:data][:attributes]).to be_a(Hash)
      expect(user_result[:data][:attributes]).to have_key(:uid)
      expect(user_result[:data][:attributes][:uid]).to eq("104505147435508023263")
      expect(user_result[:data][:attributes]).to have_key(:username)
      expect(user_result[:data][:attributes][:username]).to eq("Johnny")
      expect(user_result[:data][:attributes]).to have_key(:email)
      expect(user_result[:data][:attributes][:email]).to eq("johnny@example.com")
      expect(user_result[:data][:attributes]).to have_key(:full_name)
      expect(user_result[:data][:attributes][:full_name]).to eq("Johnny Appleseed")
      expect(user_result[:data][:attributes]).to_not have_key(:last_name)
      expect(user_result[:data][:attributes]).to have_key(:image)
      expect(user_result[:data][:attributes][:image]).to eq("https://lh3.googleusercontent.com/a/AEdFTp5vj_rzxJzWHjgqM1-InqDI0fJWxwpHK_zElpKLgA=s96-c")
    end
  end
end