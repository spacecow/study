require 'assert'

class Kanji < ActiveRecord::Base
  has_many :glossaries_kanjis
  has_many :glossaries, :through => :glossaries_kanjis

  attr_accessible :symbol, :word_id

  validates :symbol, uniqueness:true, presence:true

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
  end
end
