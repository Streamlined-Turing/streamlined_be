require 'rails_helper'

RSpec.describe MediaList do
  describe 'relationships' do
    it { should belong_to :list }
    it { should belong_to :user_media }
    it { should have_one(:user).through(:list)}
  end
end