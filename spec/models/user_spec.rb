require 'rails_helper'

RSpec.describe User do
  describe 'relationships' do
    it { should have_many :lists }
    it { should have_many(:media_lists).through(:lists) }
    it { should have_many(:user_medias).through(:media_lists) }
  end
end