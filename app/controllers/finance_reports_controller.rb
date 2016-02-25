class FinanceReportsController < ApplicationController

  def index
    if params[:filter]
      date_begin = params[:filter][:date_begin].to_date
      date_end = params[:filter][:date_end].to_date
      operations_selector = Operation.by_user(current_user.id).
                                      where("date between ? and ?", date_begin, date_end).
                                      finance_report
      @operations = operations_selector
      @operations_by_category = @operations.to_a.group_by(&:category_id).map do |category_id, operations_selector|
        {
          category_id: category_id,
          category_name: operations_selector.select{|e| e.category_id == category_id }.first.category.name,
          sum: operations_selector.sum {|operation| operation.sum.to_f }
        }.with_indifferent_access
      end
    end
  end
end
