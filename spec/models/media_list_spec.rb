require 'rails_helper'

RSpec.describe MediaList do
  describe 'relationships' do
    it { should belong_to :list }
    it { should belong_to :user_media }
    it { should have_one(:user).through(:list) }
  end

  before(:each) do
    @user = create(:user)
    @want_to_watch = @user.lists.create(name: 'want to watch')
    @currently_watching = @user.lists.create(name: 'currently watching')
    @watched = @user.lists.create(name: 'watched')
    @user_media1 = UserMedia.create(media_id: 1, user_rating: nil , user_review: '')
    @user_media2 = UserMedia.create(media_id: 2, user_rating: nil, user_review: '')
    @user_media3 = UserMedia.create(media_id: 3, user_rating: 1, user_review: 'DNF')
    @media_list1 = @want_to_watch.media_lists.create(user_media_id: @user_media1.id)
    @media_list2 = @currently_watching.media_lists.create(user_media_id: @user_media2.id)
    @media_list3 = @watched.media_lists.create(user_media_id: @user_media3.id)
  end

  describe 'instance methods' do
    describe 'destroy' do
      it 'destroys its associated user_media' do
        expect(UserMedia.all).to eq([@user_media1, @user_media2, @user_media3])

        @media_list1.destroy

        expect(UserMedia.all).to eq([@user_media2, @user_media3])
      end
    end
  end
end
