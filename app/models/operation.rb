# == Schema Information
#
# Table name: operations
#
#  id             :integer          not null, primary key
#  date           :date             not null
#  sum            :decimal(15, 2)   not null
#  source         :string(255)      not null
#  category_id    :integer          not null
#  subcategory_id :integer
#  comment        :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class Operation < ActiveRecord::Base

  SOURCES = [['Наличка', 'Наличка'], ['Пл.карта', 'Пл.карта']]

  belongs_to :category
  belongs_to :subcategory

  validates_presence_of :date, :sum, :source, :category_id
end
