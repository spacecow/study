require 'assert'

class Kanji < ActiveRecord::Base
  has_many :glossaries_kanjis
  has_many :glossaries, :through => :glossaries_kanjis

  has_many :similarities
  has_many :similars, :through => :similarities

  attr_accessible :symbol, :word_id, :similar_tokens
  attr_reader :similar_tokens

  validates :symbol, uniqueness:true, presence:true

  def similar_tokens=(tokens)
    self.similar_ids = Kanji.ids_from_tokens(tokens)
  end

  class << self
    def generate_db
      file = File.open("data/kanjidic.utf", "r")
      file.readline
      file.each_line do |line|
        kanji = line.strip[0]
        assert_equal(kanji.length, 1, "kanji file is of wrong format")
        Kanji.create(symbol:kanji)
      end
    end

    def ids_from_tokens(tokens)
      #tokens.gsub!(/<<<(.+?)>>>/){ create!(symbol:$1).id}
      tokens.split(",")
    end

    def tokens(query)
      kanjis = where("symbol = ?", query) 
      kanjis
    end
  end
end
