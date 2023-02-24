require 'rails_helper'

RSpec.describe User do
  describe 'relationships' do
    it { should have_many :lists }
    it { should have_many(:media_lists).through(:lists) }
    it { should have_many(:user_medias).through(:media_lists) }
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :uid }
    it { should validate_presence_of :image }
    it { should validate_presence_of :full_name }
  end
end
