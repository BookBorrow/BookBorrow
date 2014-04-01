# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
    title "MyString"
    description "MyText"
    isbn 1
    author ""
    cover_url "MyString"
  end
end
