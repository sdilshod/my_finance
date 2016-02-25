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

  scope :finance_report, -> {
    self.includes(:category, :subcategory).
          group(:category_id, :subcategory_id).
          select("category_id, subcategory_id, sum(sum) as sum").
          where('sum < 0')
  }

  scope :by_user, lambda {|user_id|
    where('user_id = ?', user_id)
  }

  def self.get_by user_id, params
    filter_string = ''
    date_begin = params[:date_begin]
    date_end = params[:date_end]

    query_conditions = { text: 'user_id = :user_id', params: { user_id: user_id } }

    if date_begin.blank? || date_end.blank?
    else
      query_conditions[:text] << ' and date between :date_begin and :date_end'
      query_conditions[:params][:date_begin] = date_begin.to_date
      query_conditions[:params][:date_end] = date_end.to_date
      filter_string = "Дата между '#{date_begin}' и '#{date_end}'"
    end

    search_source_name = SOURCES.select{|e| e.second.to_s == params[:source]}.first if params[:source]
    source_name = search_source_name.first if search_source_name

    params_arr = %W{source category subcategory}
    params_arr.each do |e|
      unless params[e.to_sym].blank?
        case e.to_sym
          when :source
            query_conditions[:text] << ' and source = :source '
            query_conditions[:params][:source] = params[:source]
            filter_string << " источник='#{source_name}'"
          when :category
            query_conditions[:text] << ' and category_id = :category_id '
            query_conditions[:params][:category_id] = params[:category_id]
            filter_string << " Категория='#{Category.find(params[:category]).name}'"
          when :subcategory
            query_conditions[:text] << ' and subcategory_id = :subcategory_id '
            query_conditions[:params][:subcategory_id] = params[:subcategory_id]
            filter_string << " Субкатегория='#{Subcategory.find(params[:subcategory]).name}'"
        end
      end
    end

    return where([query_conditions[:text], query_conditions[:params]]).order('date desc'), filter_string
  end

  def source_name
    result = SOURCES.select do |e|
      e.second == self.source
    end
    result.first.first
  end

end
