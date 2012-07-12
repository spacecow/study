class GlossariesKanji < ActiveRecord::Base
  belongs_to :glossary
  belongs_to :kanji

  attr_accessible :glossary_id, :kanji_id
end
