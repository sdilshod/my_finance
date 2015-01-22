# == Schema Information
#
# Table name: operations
#
#  id             :integer          not null, primary key
#  date           :date             not null
#  sum            :decimal(15, 2)   not null
#  category_id    :integer          not null
#  subcategory_id :integer
#  comment        :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  source         :integer          not null
#  user_id        :integer          not null
#

class Operation < ActiveRecord::Base

  SOURCES = [['Наличка', 1], ['Пл.карта', 2]]

  belongs_to :category
  belongs_to :subcategory
  belongs_to :user

  validates_presence_of :date, :sum, :source, :category_id

  def self.get_by user_id, params
    filter_string = ''
    if params[:date_begin].blank? || params[:date_end].blank?
      query_string =  ''
    else
      date_begin = params[:date_begin]
      date_end = params[:date_end]
      query_string = "date between '#{date_begin.to_date}' and '#{date_end.to_date}'"
      filter_string = "Дата между '#{date_begin}' и '#{date_end}'"
    end

    unless params[:source].blank?
      query_string << ' and ' unless query_string.blank?
      query_string << "source = #{params[:source]}"
      filter_string << " источник=#{params[:source]}"
    end
    unless params[:category].blank?
      query_string << ' and ' unless query_string.blank?
      query_string << "category_id = #{params[:category]}"
      filter_string << " Категория=#{Category.find(params[:category]).name}"
    end
    unless params[:subcategory].blank?
      query_string << ' and ' unless query_string.blank?
      query_string << "subcategory_id = #{params[:subcategory]}"
      filter_string << " Субкатегория=#{Subcategory.find(params[:subcategory]).name}"
    end

    #return where("id = ?", nil), '' if query_string.blank?
    return where('user_id = ?', user_id).order('date desc'), '' if query_string.blank?

    return where("user_id = ? and #{query_string}", user_id).order('date desc'), filter_string
  end

  def source_name
    result = SOURCES.select do |e|
      e.second == self.source
    end
    result.first.first
  end

end
