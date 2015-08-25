{
  subcategories: [['', '']] + @select_data.map {|e| [e.name, e.id]}
}.to_json
