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

  def self.get_by params
    query_string = params[:date_begin].blank? ? '' : "date between '#{params[:date_begin].to_date.to_s}' and '#{params[:date_end].to_date.to_s}'"
    unless params[:source].blank?
      query_string << ' and ' unless query_string.blank?
      query_string << "source = '#{params[:source]}'"
    end
    unless params[:category].blank?
      query_string << ' and ' unless query_string.blank?
      query_string << "category_id = #{params[:category]}"
    end
    unless params[:subcategory].blank?
      query_string << ' and ' unless query_string.blank?
      query_string << "subcategory_id = #{params[:subcategory]}"
    end

    return [] if query_string.blank?

    where(query_string).order('date')
  end

end
