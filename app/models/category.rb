# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer          not null
#

class Category < ActiveRecord::Base

  has_many :subcategories, dependent: :destroy
  belongs_to :user

  validates :name, presence: true

  scope :get_select_data, ->(user) { user.categories.order(:name).collect {|e| [e.name, e.id]} }
end
