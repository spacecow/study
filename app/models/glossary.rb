class Glossary < ActiveRecord::Base
  attr_accessible :english, :japanese, :sentences_attributes
  has_many :sentences
  accepts_nested_attributes_for :sentences
end
