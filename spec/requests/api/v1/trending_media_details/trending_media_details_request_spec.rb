require 'rails_helper' 

RSpec.describe 'MovieDB API' do 
  describe 'trending media details request' do 
    it 'receives the days trending media details' do 
      stub_request(:get, "https://api.watchmode.com/v1/title/3173903/details?apiKey=#{ENV["watch_mode_api_key"]}")
      .to_return(status: 200, body: File.read('spec/fixtures/breaking_bad_details_3173903.json'), headers: {})
    end
  end
end