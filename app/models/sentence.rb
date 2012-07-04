class Sentence < ActiveRecord::Base
  attr_accessible :english, :glossary_tokens, :japanese
  attr_reader :glossary_tokens

  has_many :lookups
  has_many :glossaries, :through => :lookups

  def glossary_tokens=(tokens)
    self.glossary_ids = Glossary.ids_from_tokens(tokens) 
  end

end
