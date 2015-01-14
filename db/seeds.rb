User.create email: 'example@example.com', password: 'password'

categories = %w(Дорога Машина Дом)
subcategories = %w(Субкатегория Прочие)

categories.each do |cat|

  category = Category.create name: cat

  subcategories.each do |subcat|
    subcategory = Subcategory.create name: subcat << category.name, category_id: category.id
  end
end


Operation.create([
                  { date: Date.yesterday, category_id: 1, source: Operation::SOURCES[0][0], subcategory_id: 1, sum: 5000 },
                  { date: Date.yesterday, category_id: 1, source: Operation::SOURCES[0][0], subcategory_id: 2, sum: 2000 },
                  { date: Date.today, category_id: 2, source: Operation::SOURCES[1][1], subcategory_id: 3, sum: 5550 },
                  { date: Date.today, category_id: 2, source: Operation::SOURCES[1][1], subcategory_id: 4, sum: 2500 },
                  { date: Date.tomorrow, category_id: 3, source: Operation::SOURCES[0][0], subcategory_id: 5, sum: 5500 },
                  { date: Date.tomorrow, category_id: 3, source: Operation::SOURCES[0][0], subcategory_id: 6, sum: 1500 }
                ])
