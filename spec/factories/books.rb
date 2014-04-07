# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
    title "Cather in the Rye"
    description "Horrible"
    sequence(:isbn, "100000000") { |n| n }
    author "J.D. Salinger"
    cover_url "http://readbitchesread.files.wordpress.com/2013/07/catcher-in-the-rye.jpg"
  end
end
