require 'rails_helper'

RSpec.describe Category, :type => :model do

  describe 'scopes' do

    before :each do
      @user = create(:user)
      create(:category, user: @user)
    end

    it '.ordered_by_user' do
      arr = Category.ordered_by_user @user
      expect(arr.size).to eql(1)
    end

  end

end
