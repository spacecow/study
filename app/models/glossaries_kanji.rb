class GlossariesKanji < ActiveRecord::Base
  belongs_to :glossary
  belongs_to :kanji

  attr_accessible :glossary_id, :kanji_id

  validates :kanji_id, uniqueness:{scope: :glossary_id}
end
