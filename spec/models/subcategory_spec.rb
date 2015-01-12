require 'rails_helper'

RSpec.describe Subcategory, :type => :model do

  describe 'scopes' do

    before :each do
      @categories = create_list(:category, 2)
      create_list(:subcategory, 2, category: @categories.first)
    end

    describe '.get_select_data' do
      it 'should return subcategory of category' do
        arr = Subcategory.get_select_data @categories.first.id
        expect(arr.size).to eql(2)
      end
      it 'should return subcategory with blank item' do
        arr = Subcategory.get_select_data @categories.first.id, true
        expect(arr.size).to eql(3)
      end

    end
  end

end
