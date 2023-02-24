require 'rails_helper'

RSpec.describe List do
  describe 'relationships' do
    it { should belong_to :user }
    it { should have_many :media_lists }
    it { should have_many(:user_medias).through(:media_lists) }
  end
end