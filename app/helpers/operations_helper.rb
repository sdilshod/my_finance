module OperationsHelper

  def colorize_filter_string str
    str.gsub /'[А-Яа-яA-Za-z0-9\-\b \(\)]+'/ do |repl|
      "' <span class='filter-string'>#{repl[1..-2]}</span> '"
    end
  end

  def total_currence_details detail
    cash = number_to_currency(detail[:cash], unit: '')
    card = number_to_currency(detail[:card], unit: '')
    "Наличный: #{cash} \nПластик: #{card}" if not_source_filter? && cash.to_i + card.to_i != 0
  end

private

  def not_source_filter?
    params.try(:[], :filter).try(:[], :source).blank?
  end

end
