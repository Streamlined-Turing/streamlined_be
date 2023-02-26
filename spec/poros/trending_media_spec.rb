require 'rails_helper'

RSpec.describe TrendingMedia do 
  before(:each) do 
    @media_params = {
      :adult=>false,
      :backdrop_path=>"/pxJbfnMIQQxCrdeLD0zQnWr6ouL.jpg",
      :id=>1077280,
      :title=>"Die Hart the Movie",
      :original_language=>"en",
      :original_title=>"Die Hart the Movie",
      :overview=>"Follows a fictionalized version of Kevin Hart, as he tries to become an action movie star. He attends a school run by Ron Wilcox, where he attempts to learn the ropes on how to become one of the industry's most coveted action stars.",
      :poster_path=>"/1EnBjTJ5utgT1OXYBZ8YwByRCzP.jpg",
      :media_type=>"movie",
      :genre_ids=>[
          28,
          35,
          53
      ],
      :popularity=>47.951,
      :release_date=>"2023-02-24",
      :video=>false,
      :vote_average=>6.3,
      :vote_count=>15
    }
  end

  it 'exists with attributes' do 
    media = TrendingMedia.new(@media_params)

    expect(media).to be_a TrendingMedia
    expect(media.id).to eq(1077280)
    expect(media.title).to eq("Die Hart the Movie")
    expect(media.poster_path).to eq("/1EnBjTJ5utgT1OXYBZ8YwByRCzP.jpg")
    expect(media.media_type).to eq("movie")
    expect(media.vote_average).to eq(6.3)
  end
end