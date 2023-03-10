require 'rails_helper'

RSpec.describe Media do
  before(:each) do
    @heavy_media_data = { :id => 3173903,
                          :title => 'Breaking Bad',
                          :original_title => 'Breaking Bad',
                          :plot_overview =>
       'Guy things cancer is excuse to do crime.',
                          :type => 'tv_series',
                          :runtime_minutes => 45,
                          :year => 2008,
                          :end_year => 2013,
                          :release_date => '2008-01-20',
                          :imdb_id => 'tt0903747',
                          :tmdb_id => 1396,
                          :tmdb_type => 'tv',
                          :genres => nil,
                          :genre_names => ['Drama', 'Dark Comedy'],
                          :user_rating => 9.3,
                          :critic_score => 85,
                          :us_rating => 'TV-MA',
                          :poster => 'https://cdn.watchmode.com/posters/03173903_poster_w185.jpg',
                          :backdrop => 'https://cdn.watchmode.com/backdrops/03173903_bd_w780.jpg',
                          :original_language => 'en',
                          :similar_titles => [3131293],
                          :networks => [8],
                          :network_names => ['AMC'],
                          :relevance_percentile => 98.8,
                          :trailer => 'https://www.youtube.com/watch?v=5NpEA2yaWVQ',
                          :trailer_thumbnail => 'https://cdn.watchmode.com/video_thumbnails/536028_pthumbnail_320.jpg',
                          :sources =>
       [{ :source_id => 349,
          :name => 'iTunes',
          :type => 'buy',
          :region => 'US',
          :ios_url => 'Deeplinks available for paid plans only.',
          :android_url => 'Deeplinks available for paid plans only.',
          :web_url => 'https://itunes.apple.com/us/tv-season/felina/id665386598?i=717897170&at=10laHb',
          :format => 'SD',
          :price => 1.99,
          :seasons => nil,
          :episodes => nil },
        { :source_id => 349,
          :name => 'iTunes',
          :type => 'buy',
          :region => 'US',
          :ios_url => 'Deeplinks available for paid plans only.',
          :android_url => 'Deeplinks available for paid plans only.',
          :web_url => 'https://itunes.apple.com/us/tv-season/felina/id665386598?i=717897170&at=10laHb',
          :format => 'HD',
          :price => 2.99,
          :seasons => nil,
          :episodes => nil },
        { :source_id => 203,
          :name => 'Netflix',
          :type => 'sub',
          :region => 'US',
          :ios_url => 'Deeplinks available for paid plans only.',
          :android_url => 'Deeplinks available for paid plans only.',
          :web_url => 'https://www.netflix.com/watch/70236428',
          :format => '4K',
          :price => nil,
          :seasons => nil,
          :episodes => nil }] }
    @lite_media_data = {
      name: 'Everything Everywhere All at Once',
      relevance: 250,
      type: 'movie',
      id: 1516721,
      year: 2022,
      result_type: 'title',
      tmdb_id: 545611,
      tmdb_type: 'movie',
      image_url: 'https://cdn.watchmode.com/posters/01516721_poster_w185.jpg'
    }
  end

  it 'can be created with detailed data' do
    media = Media.new(@heavy_media_data)

    expect(media).to be_a Media
    expect(media.title).to eq('Breaking Bad')
    expect(media.audience_score).to eq(9.3)
    expect(media.rating).to eq('TV-MA')
    expect(media.media_type).to eq('tv_series')
    expect(media.description).to eq('Guy things cancer is excuse to do crime.')
    expect(media.genres).to eq(['Drama', 'Dark Comedy'])
    expect(media.release_year).to eq(2008)
    expect(media.runtime).to eq(45)
    expect(media.language).to eq('en')
    expect(media.sub_services).to eq(['Netflix'])
    expect(media.poster).to eq('https://cdn.watchmode.com/posters/03173903_poster_w185.jpg')
    expect(media.imdb_id).to eq('tt0903747')
    expect(media.tmdb_id).to eq(1396)
    expect(media.tmdb_type).to eq('tv')
    expect(media.trailer).to eq('https://www.youtube.com/watch?v=5NpEA2yaWVQ')
  end

  it 'can be created with less detailed data' do
    media = Media.new(@lite_media_data)

    expect(media).to be_a Media
    expect(media.title).to eq('Everything Everywhere All at Once')
    expect(media.audience_score).to be nil
    expect(media.rating).to be nil
    expect(media.media_type).to eq('movie')
    expect(media.description).to be nil
    expect(media.genres).to be nil
    expect(media.release_year).to eq(2022)
    expect(media.runtime).to be nil
    expect(media.language).to be nil
    expect(media.sub_services).to eq([])
    expect(media.poster).to eq('https://cdn.watchmode.com/posters/01516721_poster_w185.jpg')
    expect(media.imdb_id).to be nil
    expect(media.tmdb_id).to eq(545611)
    expect(media.tmdb_type).to eq('movie')
    expect(media.trailer).to be nil
  end

  it 'can be created with user list information' do
    user = create(:user) 
    list = user.lists.first
    user_media = create(:user_media, media_id: 3173903) 
    MediaList.create(list: list, user_media: user_media) 
    media = Media.new(@heavy_media_data, user.id)

    expect(media.user_lists).to eq "Want to Watch"
  end
  
  it 'only returns list information for this piece of media' do
    user = create(:user) 
    list = user.lists.first
    other_list = user.lists.last
    user_media = create(:user_media, media_id: 3173903) 
    user_media2 = create(:user_media) 
    MediaList.create(list: list, user_media: user_media) 
    MediaList.create(list: other_list, user_media: user_media2) 
    media = Media.new(@heavy_media_data, user.id)

    expect(media.user_lists).to eq "Want to Watch"
  end

  it 'has the time it was last put on a list' do
    user = create(:user) 
    list = user.lists.first
    user_media = create(:user_media, media_id: 3173903) 
    media_list = MediaList.create(list: list, user_media: user_media) 
    updated_at = media_list.updated_at
    media = Media.new(@heavy_media_data, user.id)

    expect(media.added_to_list_on).to be_within(1.second).of updated_at
  end

  it 'can be created with user rating information' do
    user = create(:user) 
    list = user.lists.first
    user_media = create(:user_media, media_id: 3173903, user_rating: 2) 
    MediaList.create(list: list, user_media: user_media) 
    media = Media.new(@heavy_media_data, user.id)

    expect(media.user_rating).to eq 2
  end

  it 'only returns user rating for this piece of media for this user' do
    user = create(:user) 
    list = user.lists.first
    other_list = user.lists.last
    user_media = create(:user_media, media_id: 3173903, user_rating: 3) 
    user_media2 = create(:user_media, user_rating: 5)
    MediaList.create(list: list, user_media: user_media) 
    MediaList.create(list: other_list, user_media: user_media2) 
    media = Media.new(@heavy_media_data, user.id)

    expect(media.user_rating).to eq 3
  end


  describe '#subscription_services' do
    it 'returns the services media is available with a subscription' do
      media0 = Media.new({ :sources => [] })
      media1 = Media.new(@heavy_media_data)
      media2 = Media.new(:sources =>
        [{ :source_id => 349,
           :name => 'Prime',
           :type => 'sub',
           :region => 'US',
           :ios_url => 'Deeplinks available for paid plans only.',
           :android_url => 'Deeplinks available for paid plans only.',
           :web_url => 'https://itunes.apple.com/us/tv-season/felina/id665386598?i=717897170&at=10laHb',
           :format => 'SD',
           :price => nil,
           :seasons => nil,
           :episodes => nil },
         { :source_id => 349,
           :name => 'iTunes',
           :type => 'buy',
           :region => 'US',
           :ios_url => 'Deeplinks available for paid plans only.',
           :android_url => 'Deeplinks available for paid plans only.',
           :web_url => 'https://itunes.apple.com/us/tv-season/felina/id665386598?i=717897170&at=10laHb',
           :format => 'HD',
           :price => 2.99,
           :seasons => nil,
           :episodes => nil },
         { :source_id => 203,
           :name => 'Netflix',
           :type => 'sub',
           :region => 'US',
           :ios_url => 'Deeplinks available for paid plans only.',
           :android_url => 'Deeplinks available for paid plans only.',
           :web_url => 'https://www.netflix.com/watch/70236428',
           :format => '4K',
           :price => nil,
           :seasons => nil,
           :episodes => nil }])

      expect(media0.subscription_services).to eq([])
      expect(media1.subscription_services).to eq(['Netflix'])
      expect(media2.subscription_services.sort).to eq(['Netflix', 'Prime'].sort)
    end
  end
end
