class Sentence < ActiveRecord::Base
  attr_accessible :english, :glossary_tokens, :japanese
  attr_reader :glossary_tokens

  has_many :lookups
  has_many :glossaries, :through => :lookups

  def glossary_tokens=(tokens)
    self.glossary_ids = Glossary.ids_from_tokens(tokens) 
  end

  class << self
    def ids_from_tokens(tokens)
      tokens.gsub!(/<<<(.+?)>>>/){ create!(japanese:$1).id}
      tokens.split(",")
    end
  end

  #  def tokens(query)
  #    sentences = where("japanese like ?", "%#{query}%")
  #    if sentences.empty?
  #      [{id: "<<<#{query}>>>", japanese: "New: \"#{query}\""}]
  #    else
  #      sentences
  #    end
  #  end
  #end 
end
