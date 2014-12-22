class Operation < ActiveRecord::Base
  validates_presence_of :date, :sum, :source, :category_id
end
