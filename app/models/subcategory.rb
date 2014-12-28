# == Schema Information
#
# Table name: subcategories
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  created_at  :datetime
#  updated_at  :datetime
#  category_id :integer          not null
#

class Subcategory < ActiveRecord::Base

  belongs_to :category

  validates :name, presence: true

  scope :get_select_data, -> { order(:name).collect {|e| [e.name, e.id]} }
end
