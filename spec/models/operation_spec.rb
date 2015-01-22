require 'rails_helper'

RSpec.describe Operation, :type => :model do

  describe '.get_by' do

    before :each do
      @user = create :user
      @categories = create_list :category, 2, user: @user
      @subcategories = create_list :subcategory, 2, category: @categories.first
      create_list(:operation, 2,
                  user: @user,
                  source: Operation::SOURCES[0][1],
                  category: @categories.first,
                  subcategory: @subcategories.first
                 )
      create_list(:operation, 2,
                  user: @user,
                  source: Operation::SOURCES[1][1],
                  category: @categories.first,
                  subcategory: @subcategories.second
                 )
    end


    it 'should return result' do
      params = {
                 date_begin: 2.days.ago,
                 date_end: Date.today,
                 source: Operation::SOURCES[0][1],
                 category: @categories[0].id.to_s,
                 subcategory: @subcategories[0].id.to_s
               }

      collection, filter_string = Operation.get_by @user.id, params
      expect(collection.size).to eq(2)
      expect(filter_string).not_to be_blank
    end

    it 'should return blank result' do
      collection, filter_string = Operation.get_by @user.id,
                                                   date_begin: nil,
                                                   date_end: nil,
                                                   source: nil,
                                                   category: nil,
                                                   subcategory: nil
      expect(collection).not_to be_blank
      expect(filter_string).to be_blank
    end
  end

end
