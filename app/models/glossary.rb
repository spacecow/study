class Glossary < ActiveRecord::Base
  has_many :lookups
  has_many :sentences, :through => :lookups

  has_many :glossaries_kanjis
  has_many :kanjis, :through => :glossaries_kanjis

  attr_accessible :content, :sentence_tokens
  attr_reader :sentence_tokens

  def links_to_kanjis
    kanji_array.each{|e| kanjis << Kanji.find_by_symbol(e)} if kanjis.empty?
  end

  def kanji_array
    content.split('').select{|e| Kanji.exists?(symbol:e)} unless content.nil?
  end

  def sentence_tokens=(tokens)
    self.sentence_ids = Sentence.ids_from_tokens(tokens)
  end

  class << self
    def ids_from_tokens(tokens)
      tokens.gsub!(/<<<(.+?)>>>/){ create!(content:$1).id}
      tokens.split(",")
    end

    def links_to_kanjis
      all.each{|e| e.links_to_kanjis}
    end

    def tokens(query)
      glossaries = where("content like ?", "%#{query}%")
      if glossaries.empty?
        [{id: "<<<#{query}>>>", content: "New: \"#{query}\""}]
      else
        glossaries
      end
    end
  end 
end
