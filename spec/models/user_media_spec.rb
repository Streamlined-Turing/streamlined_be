require 'rails_helper'

RSpec.describe UserMedia do
  describe 'relationships' do
    it { should have_one :media_list }
    it { should have_one(:list).through(:media_list) }
    it { should have_one(:user).through(:list) }
  end

  describe 'validations' do
    it { should validate_numericality_of(:user_rating).only_integer }
    it { should validate_numericality_of(:user_rating).is_in(0..5) }
  end
end
