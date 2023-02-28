require 'rails_helper'

RSpec.describe MediaFacade do
  before(:each) do
    @breaking_bad_id = 3173903
    stub_request(:get, "https://api.watchmode.com/v1/title/3173903/details?apiKey=#{ENV['watch_mode_api_key']}&append_to_response=sources")
      .to_return(status: 200, body: File.read('spec/fixtures/breaking_bad_details_3173903.json'), headers: {})

    @query = 'everything'
    stub_request(:get, "https://api.watchmode.com/v1/autocomplete-search/?search_field=name&search_value=#{@query}&search_type=2&apiKey=#{ENV['watch_mode_api_key']}")
      .to_return(status: 200, body: File.read('spec/fixtures/media_search_everything.json'), headers: {})
  end

  describe '.details' do
    it 'returns a media details object' do
      media_details = MediaFacade.details(@breaking_bad_id)

      expect(media_details).to be_a Media
      expect(media_details.id).to eq(@breaking_bad_id)
    end
  end

  describe '.search' do
    it 'returns an array of media objects' do
      search_results = MediaFacade.search(@query)

      search_results.each do |result|
        expect(result).to be_a Media
      end
    end
  end

  describe '.user_list_details' do
    it 'returns an array of media objects on a particular users list' do
      user = create(:user)
      currently_watching_list = user.lists.find_by("name ILIKE ?", "currently watching")
      breaking_bad = create(:user_media, media_id: 3173903)
      MediaList.create(list: currently_watching_list, user_media: breaking_bad)


      currently_watching_list = MediaFacade.user_list_details(user.id, "currently watching")

      currently_watching_list.each do |media|
        expect(media).to be_a(Media)
      end
    end

    it 'returns an empty array if list has no media' do
      user = create(:user)
      currently_watching_list = MediaFacade.user_list_details(user.id, "currently watching")
      expect(currently_watching_list).to be_empty
    end

    it 'returns an empty array if list name does not exist' do
      user = create(:user)
      not_a_list = MediaFacade.user_list_details(user.id, "not a list")
      expect(not_a_list).to be_empty
    end
  end
end
