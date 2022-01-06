FactoryBot.define do
  factory :category do
    user { User.new }
    title { "sample category sample" }
    description { "a category sample" }
  end
end