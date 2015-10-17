# -*- coding: utf-8 -*-
FactoryGirl.define do
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
  end

  factory :similarity do
  end

  factory :synonym_glossary do
    glossary
  end

  factory :translation do
    key "Factory Key"
    locale
  end

  factory :user do
    password 'secret'
  end
end
