require 'rails_helper'

RSpec.describe 'Watchmode API' do 
  describe 'media details request' do 
    before(:each) do
      stub_request(:get, "https://api.watchmode.com/v1/title/3173903/details?apiKey=#{ENV['watch_mode_api_key']}")
        .to_return(status: 200, body: File.read('spec/fixtures/breaking_bad_details_3173903.json'), headers: {})
    end

    it 'receives media details' do 
      show_id = 3173903
      get "/api/v1/media_details/#{show_id}"

      media_data = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(media_data).to be_a Hash
      expect(media_data.keys).to eq([:data])
      expect(media_data[:data]).to be_a Hash
      expect(media_data[:data].keys.sort).to eq([:type, :id, :attributes].sort)
      expect(media_data[:data][:id]).to be_a String
      expect(media_data[:data][:type]).to eq('media')
      expect(media_data[:data][:attributes]).to be_a Hash
      expect(media_data[:data][:attributes].keys.sort).to eq([
        :id,
        :title,
        :audience_score,
        :rating,
        :type,
        :description,
        :genres,
        :release_year,
        :runtime,
        :language,
        :sub_services,
        :poster
      ].sort)
      expect(media_data[:data][:attributes][:id]).to be_an Integer
      expect(media_data[:data][:attributes][:title]).to be_a String
      expect(media_data[:data][:attributes][:audience_score]).to be_a Float
      expect(media_data[:data][:attributes][:rating]).to be_a String
      expect(media_data[:data][:attributes][:type]).to be_a String
      expect(media_data[:data][:attributes][:description]).to be_a String
      expect(media_data[:data][:attributes][:genres]).to be_an Array
      expect(media_data[:data][:attributes][:release_year]).to be_an Integer
      expect(media_data[:data][:attributes][:runtime]).to be_an Integer
      expect(media_data[:data][:attributes][:language]).to be_a String
      expect(media_data[:data][:attributes][:sub_services]).to be_an Array
      media_data[:data][:attributes][:sub_services].each do |service|
        expect(service).to be_a String
      end
      expect(media_data[:data][:attributes][:poster]).to be_a String
    end
  end
end