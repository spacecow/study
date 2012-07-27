FactoryGirl.define do
  factory :glossary do
    content "a"
  end

  factory :kanji do
    symbol "a"
  end

  factory :project do
    name 'Factory Name'
  end

  factory :sentence do
    project
  end

  factory :user do
  end
end
