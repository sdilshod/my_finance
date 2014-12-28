# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base

  has_many :subcategories

  validates :name, presence: true

  scope :get_select_data, -> { order(:name).collect {|e| [e.name, e.id]} }
end
