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
    end
  end
end
