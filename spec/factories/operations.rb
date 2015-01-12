FactoryGirl.define do

  factory :operation do
    date Faker::Date.between(2.days.ago, Date.today)
    sum Faker::Number.number(4)
  end

end
