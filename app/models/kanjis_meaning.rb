class KanjisMeaning < ActiveRecord::Base
  belongs_to :kanji
  belongs_to :meaning

  attr_accessible :kanji_id, :meaning_id
end
