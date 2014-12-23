require 'rails_helper'

RSpec.describe Subcategory, :type => :model do
  describe 'scopes' do

    before :all do
      @cat_road = create(:category_road)
      @cat_house = create(:category_house)
      @cat_road.subcategories << Subcategory.new(name: 'В работу')
      @cat_road.subcategories << Subcategory.new(name: 'Разные')
    end

    it '.get_select_data' do
      arr = Subcategory.get_select_data
      expect(arr[0].size).to eql(2)
    end

  end

end
