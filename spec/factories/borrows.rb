# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :borrow do
    user_book_id 1
    user_id 2
    borrow_date "2014-04-01"
    duration_in_days 7
  end
end
