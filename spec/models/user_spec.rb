require 'rails_helper'

RSpec.describe User do
  describe 'relationships' do
    it { should have_many :lists }
    it { should have_many(:media_lists).through(:lists) }
    it { should have_many(:user_medias).through(:media_lists) }
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :sub }
    it { should validate_presence_of :picture }
    it { should validate_presence_of :name }
  end

  describe '#create_default_lists' do
    it 'creates the 3 default lists for the user after a user is validated' do
      user = create(:user)

      expect(user.lists.count).to eq(3)
      expect(user.lists.first.name).to eq('Want to Watch')
      expect(user.lists.second.name).to eq('Currently Watching')
      expect(user.lists.third.name).to eq('Watched')
    end
  end

  describe '#media_ids_for' do
    it 'returns an array of media ids given a list name for a particular user' do
      user = create(:user)
      
      currently_watching_list = user.lists.find_by("name ILIKE ?", "currently watching")
      want_to_watch_list = user.lists.find_by("name ILIKE ?", "want to watch")
      
      game_of_thrones = create(:user_media, media_id: 345534)
      breaking_bad = create(:user_media, media_id: 3173903)
      test_media = create(:user_media, media_id: 1234)
      
      MediaList.create(list: currently_watching_list, user_media: game_of_thrones)
      MediaList.create(list: want_to_watch_list, user_media: breaking_bad)
      MediaList.create(list: want_to_watch_list, user_media: test_media)

      expect(user.media_ids_for("currently watching")).to eq([345534])
      expect(user.media_ids_for("want to watch")). to eq([3173903, 1234])
      expect(user.media_ids_for("watched")).to eq([])
    end
  end

  describe '#has_list_name?' do
    it 'checks if a list record exists given a case insensitive name or gives an error' do
      user = create(:user)

      expect(user.has_list_name?("currently WatcHing")).to be true
      expect(user.has_list_name?("fake list")).to be false
    end
  end
end
