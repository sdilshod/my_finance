class Operation < ActiveRecord::Base

  SOURCES = [['Наличка', 'Наличка'], ['Пл.карта', 'Пл.карта']]

  belongs_to :category
  belongs_to :subcategory

  validates_presence_of :date, :sum, :source, :category_id
end
