class Category < ActiveRecord::Base

  has_many :subcategories

  validates :name, presence: true

  scope :get_select_data, -> { order(:name).collect {|e| [e.name, e.id]} }
end
