class Subcategory < ActiveRecord::Base

  belongs_to :category

  validates :name, presence: true

  scope :get_select_data, -> { order(:name).collect {|e| [e.name, e.id]} }
end
