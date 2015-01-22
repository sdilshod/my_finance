require 'rails_helper'

RSpec.describe Category, :type => :model do

  describe 'scopes' do

    before :each do
      @user = create(:user)
      create(:category, user: @user)
    end

    it '.get_select_data' do
      arr = Category.get_select_data @user
      expect(arr[0].size).to eql(2)
    end

  end

end
