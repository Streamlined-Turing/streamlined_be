require 'rails_helper'

RSpec.describe UserMedia do
  describe 'relationships' do
    it { should have_one :media_list }
    it { should have_one(:list).through(:media_list) }
    it { should have_one(:user).through(:list) }
  end
end
