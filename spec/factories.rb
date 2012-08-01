FactoryGirl.define do
  factory :glossary do
    content "a"
  end

  factory :kanji do
    symbol "a"
  end

  factory :locale do
  end

  factory :meaning do
  end

  factory :project do
    name 'Factory Name'
  end

  factory :sentence do
    project
  end

  factory :translation do
    key "Factory Key"
    locale
  end

  factory :user do
  end
end
