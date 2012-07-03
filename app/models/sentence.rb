class Sentence < ActiveRecord::Base
  attr_accessible :english, :glossary_id, :japanese
  belongs_to :glossary
end
