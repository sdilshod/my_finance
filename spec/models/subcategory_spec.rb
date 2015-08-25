require 'rails_helper'

RSpec.describe Subcategory, :type => :model do

  describe 'scopes' do

    before :each do
      @user = create :user
      @categories = create_list :category, 2, user: @user
      create_list :subcategory, 2, category: @categories.first
    end

    describe '.ordered_by_category' do
      it 'should return subcategory of category' do
        arr = Subcategory.ordered_by_category @categories.first.id
        expect(arr.size).to eql(2)
      end
    end
  end

end
