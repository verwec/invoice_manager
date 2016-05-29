FactoryGirl.define do
  factory :order do
    order_uid Faker::Number.number(2)
    order_date Faker::Date.forward(1)
    course_start Faker::Date.forward(21)
    course_end Faker::Date.forward(28)
    payment_date Faker::Date.forward(7)
    product 'Schmwimmen 01'
    price 9900
    customer
  end
end
