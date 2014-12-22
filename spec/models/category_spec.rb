require 'rails_helper'

RSpec.describe Category, :type => :model do

  describe 'scopes' do

    before :all do
      @cat_road = create(:category_road)
      @cat_house = create(:category_house)
    end

    it '.get_select_data' do
      arr = Category.get_select_data
      expect(arr[0].size).to eql(2)
    end

  end

end
