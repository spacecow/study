class Lookup < ActiveRecord::Base
  attr_accessible :glossary_id, :sentence_id

  belongs_to :glossary
  belongs_to :sentence
end
