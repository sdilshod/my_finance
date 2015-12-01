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
    date_begin = params[:date_begin]
    date_end = params[:date_end]

    if date_begin.blank? || date_end.blank?
      query_string =  ''
    else
      query_string = "date between '#{date_begin.to_date}' and '#{date_end.to_date}'"
      filter_string = "Дата между '#{date_begin}' и '#{date_end}'"
    end

    search_source_name = SOURCES.select{|e| e.second.to_s == params[:source]}.first if params[:source]
    source_name = search_source_name.first if search_source_name

    params_arr = %W{source category subcategory}
    params_arr.each do |e|
      unless params[e.to_sym].blank?
        query_string << ' and ' unless query_string.blank?
        case e.to_sym
          when :source
            query_string << "source = #{params[:source]}"
            filter_string << " источник='#{source_name}'"
          when :category
            query_string << "category_id = #{params[:category]}"
            filter_string << " Категория='#{Category.find(params[:category]).name}'"
          when :subcategory
            query_string << "subcategory_id = #{params[:subcategory]}"
            filter_string << " Субкатегория='#{Subcategory.find(params[:subcategory]).name}'"
        end
      end
    end

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
