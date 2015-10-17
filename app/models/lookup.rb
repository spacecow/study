class Lookup < ActiveRecord::Base
  attr_accessible :glossary_id, :sentence_id, :meaning

  belongs_to :glossary
  belongs_to :sentence

#  after_create :link_kanji

  private

    #def link_kanji
    #  Glossary.find(self[:glossary_id]).link_to_kanjis
    #end
end
