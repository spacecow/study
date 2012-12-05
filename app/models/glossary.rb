class Glossary < ActiveRecord::Base
  has_many :lookups
  has_many :sentences, :through => :lookups

  has_many :glossaries_kanjis
  has_many :kanjis, :through => :glossaries_kanjis

  has_many :synonym_glossaries
  has_many :synonyms, through: :synonym_glossaries
  has_many :inverse_synonym_glossaries, class_name:'SynonymGlossary', foreign_key:'synonym_id'
  has_many :inverse_synonyms, through: :inverse_synonym_glossaries, source: :glossary

  has_many :similar_glossaries
  has_many :similars, through: :similar_glossaries
  has_many :inverse_similar_glossaries, class_name:'SimilarGlossary', foreign_key:'similar_id'
  has_many :inverse_similars, through: :inverse_similar_glossaries, source: :glossary

  has_many :antonym_glossaries
  has_many :antonyms, through: :antonym_glossaries
  has_many :inverse_antonym_glossaries, class_name:'AntonymGlossary', foreign_key:'antonym_id'
  has_many :inverse_antonyms, through: :inverse_antonym_glossaries, source: :glossary


  attr_accessible :content, :reading, :sentence_tokens, :similar_tokens, :synonym_tokens, :antonym_tokens
  attr_reader :sentence_tokens, :similar_tokens, :synonym_tokens, :antonym_tokens

  validates :content, presence:true, uniqueness:true

  def antonym_tokens=(tokens)
    self.antonym_ids = Glossary.ids_from_tokens(tokens)
  end
  def antonyms_total; antonyms+inverse_antonyms end

  def display
    "#{content}(#{reading})"
  end

  def link; [display, self] end
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
  def synonyms_total; synonyms+inverse_synonyms end

  def synonym_tokens=(tokens)
    self.synonym_ids = Glossary.ids_from_tokens(tokens)
  end

  class << self
    def ids_from_tokens(tokens)
      tokens.gsub!(/<<<(.+?)>>>/){ create!(content:$1).id}
      tokens.split(",")
    end

    def link_to_kanjis
      all.each{|e| e.link_to_kanjis}
    end

    def tokens(query)
      where("content like ?", "%#{query}%") + [{id: "<<<#{query}>>>", content: "New: \"#{query}\""}]
    end
  end 
end
