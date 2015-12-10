module OperationsHelper

  def colorize_filter_string str
    str.gsub /'[А-Яа-яA-Za-z0-9\-\b \(\)]+'/ do |repl|
      "' <span class='filter-string'>#{repl[1..-2]}</span> '"
    end
  end

end
