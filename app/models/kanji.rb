# -*- coding: utf-8 -*-
require 'assert'

class Kanji < ActiveRecord::Base
  has_many :glossaries_kanjis
  has_many :glossaries, :through => :glossaries_kanjis

  has_many :similarities
  has_many :similars, :through => :similarities

  has_many :kanjis_meanings
  has_many :meanings, :through => :kanjis_meanings

  attr_accessible :symbol, :word_id, :similar_tokens
  attr_reader :similar_tokens

  validates :symbol, uniqueness:true, presence:true

  def character; symbol end
  def link; [symbol,self] end
  #def random_glossary_link(taken_glossary=nil)
  # # glossaries.reject{|e| e==taken_glossary}.map{|e| [e.display, e]}.sample
  # glossaries.reject{|e| e==taken_glossary}.map(&:link).sample
  #end
  def random_glossary(taken_glossary=nil)
    glossaries.reject{|e| e==taken_glossary}.sample
    #glossaries.reject{|e| e==taken_glossary}.sample
  end

  def similar_tokens=(tokens)
    self.similar_ids = Kanji.ids_from_tokens(tokens)
  end

  def to_s; symbol end

  class << self
    def generate_db(file = 'kanjidic.utf')
      file = File.open("data/#{file}", "r")
      file.readline
      file.each_line do |line|
        kanji = line.split[0]
        assert_equal(kanji.length, 1, "kanji file is of wrong format")
        kanji = Kanji.create(symbol:kanji)

        splits = line.split('{')
        while data = splits.pop.match(/(.+)\}/)
          kanji.meanings << Meaning.find_or_create_by_name(data[1])
        end
      end
    end

    def ids_from_tokens(tokens)
      #tokens.gsub!(/<<<(.+?)>>>/){ create!(symbol:$1).id}
      tokens.split(",")
    end

    def kanji_array(s)
      return [] if s.nil?
      s.split('').select{|e| Kanji.exists? symbol:e}
    end

    def tokens(query)
      kanjis = where("symbol = ?", query) 
      kanjis
    end
  end
end
