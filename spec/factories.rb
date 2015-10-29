if FactoryGirl.factories.instance_variable_get('@items').empty?

# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :definition do
    glossary
  end

  factory :glossary do
    sequence(:content){|n| "Factory content #{n}"}
  end

  factory :kanji do
    symbol "魔"
  end

  factory :locale do
  end

  factory :lookup do
  end

  factory :meaning do
  end

  factory :project do
    name 'Factory Name'
  end

  factory :quiz do
  end

  factory :sentence do
    project
    japanese:"factory japanese"
  end

  factory :similarity do
  end

  factory :synonym_glossary do
    glossary
  end

  factory :antonym_glossary do
  end

  factory :similar_glossary do
  end

  factory :translation do
    key "Factory Key"
    locale
  end

  factory :user do
    password 'secret'
  end
end

end
