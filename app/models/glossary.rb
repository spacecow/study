class Glossary < ActiveRecord::Base
  attr_accessible :english, :japanese, :sentence_tokens
  attr_reader :sentence_tokens

  has_many :lookups
  has_many :sentences, :through => :lookups

  def sentence_tokens=(tokens)
    self.sentence_ids = Sentence.ids_from_tokens(tokens)
  end

  class << self
    def ids_from_tokens(tokens)
      tokens.gsub!(/<<<(.+?)>>>/){ create!(japanese:$1).id}
      tokens.split(",")
    end

    def tokens(query)
      glossaries = where("japanese like ?", "%#{query}%")
      if glossaries.empty?
        [{id: "<<<#{query}>>>", japanese: "New: \"#{query}\""}]
      else
        glossaries
      end
    end
  end 
end
