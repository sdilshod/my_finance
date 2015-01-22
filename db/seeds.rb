User.destroy_all
puts 'Deleted all records assocation with user'

puts 'Adding users ...'
user = User.create email: 'example@example.com', password: 'password'
user_guest = User.create email: 'guest@guest.com', password: 'password'

categories = %w(Дорога Машина Дом)
subcategories = %w(Субкатегория Прочие)

puts 'Adding category and subcategories of user ...'
2.times do |t|
  categories.each do |cat|

    category = Category.create name: cat, user: t == 0 ? user : user_guest

    subcategories.each do |subcat|
      subcategory = Subcategory.create name: subcat << category.name, category_id: category.id
    end
  end
end

puts 'Adding user operations ...'
2.times do |t|
  operation_user = t == 0 ? user : user_guest
  categories_id = operation_user.categories.pluck :id
  subcategories_id = operation_user.subcategories.pluck :id
  Operation.create([
                    { date: Date.yesterday, category_id: categories_id[0],
                      user: operation_user, source: Operation::SOURCES[0][1], subcategory_id: subcategories_id[0], sum: 5000
                    },
                    { date: Date.yesterday, category_id: categories_id[0],
                      user: operation_user, source: Operation::SOURCES[0][1], subcategory_id: subcategories_id[1], sum: 2000
                    },
                    { date: Date.today, category_id: categories_id[1],
                      user: operation_user, source: Operation::SOURCES[1][1], subcategory_id: subcategories_id[2], sum: 5550
                    },
                    { date: Date.today, category_id: categories_id[1],
                      user: operation_user, source: Operation::SOURCES[1][1], subcategory_id: subcategories_id[3], sum: 2500
                    },
                    { date: Date.tomorrow, category_id: categories_id[2],
                      user: operation_user, source: Operation::SOURCES[0][1], subcategory_id: subcategories_id[4], sum: 5500
                    },
                    { date: Date.tomorrow, category_id: categories_id[2],
                      user: operation_user, source: Operation::SOURCES[0][1], subcategory_id: subcategories_id[5], sum: 1500
                    }
                  ])
end
