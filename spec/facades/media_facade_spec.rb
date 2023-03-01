require 'rails_helper'

RSpec.describe MediaFacade, :vcr do
  before(:each) do
    @breaking_bad_id = 3173903
    @query = 'everything'
  end

  describe '.details' do
    it 'returns a media details object' do
      media_details = MediaFacade.details(@breaking_bad_id)

      expect(media_details).to be_a Media
      expect(media_details.id).to eq(@breaking_bad_id)
      expect(media_details.user_lists).to eq('None')
    end

    it 'can optionally include data about a users lists' do
      user = create(:user) 
      list = user.lists.last
      user_media = create(:user_media, media_id: 3173903) 
      MediaList.create(list: list, user_media: user_media) 
      media_details = MediaFacade.details(@breaking_bad_id, user.id)

      expect(media_details).to be_a Media
      expect(media_details.id).to eq(@breaking_bad_id)
      expect(media_details.user_lists).to eq('Watched')
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
