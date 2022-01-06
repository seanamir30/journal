FactoryBot.define do
  factory :task do
    category { Category.new }
    title { "sample title task" }
    description { "a task description" }
    due_date { Date.current + 1.week }

    trait :today do
      due_date { Date.today }
    end
    
    trait :marked do
      is_done { true }
    end

    trait :unmarked do
      is_done { false }
    end
  end
end