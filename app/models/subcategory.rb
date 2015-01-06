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

  scope :get_select_data, ->(category_id, filter_action = false) do
    arr = where('category_id = ?', category_id).order(:name).collect {|e| [e.name, e.id]}
    return [['', '']] + arr if filter_action
    arr
  end
end
