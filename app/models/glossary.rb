class Glossary < ActiveRecord::Base
  has_many :lookups
  has_many :sentences, :through => :lookups

  has_many :glossaries_kanjis
  has_many :kanjis, :through => :glossaries_kanjis

  has_many :similar_glossaries
  has_many :similars, through: :similar_glossaries
  has_many :inverse_similar_glossaries, class_name:'SimilarGlossary', foreign_key:'similar_id'
  has_many :inverse_similars, through: :inverse_similar_glossaries, source: :glossary

  attr_accessible :content, :reading, :sentence_tokens, :similar_tokens
  attr_reader :sentence_tokens, :similar_tokens

  validates :content, presence:true, uniqueness:true

  def display
    "#{content}(#{reading})"
  end

  def link_to_kanjis
    kanji_array.each{|e| kanjis << Kanji.find_by_symbol(e)} if kanjis.empty?
  end

  def kanji_array
    content.split('').select{|e| Kanji.exists?(symbol:e)} unless content.nil?
  end

  def sentence_tokens=(tokens)
    self.sentence_ids = Sentence.ids_from_tokens(tokens)
  end

  def similar_tokens=(tokens)
    self.similar_ids = Glossary.ids_from_tokens(tokens)
  end

  def similars_total; similars+inverse_similars end

  class << self
    def ids_from_tokens(tokens)
      tokens.gsub!(/<<<(.+?)>>>/){ create!(content:$1).id}
      tokens.split(",")
    end

    def link_to_kanjis
      all.each{|e| e.link_to_kanjis}
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
