class Similarity < ActiveRecord::Base
  belongs_to :kanji
  belongs_to :similar, :class_name => 'Kanji'

  attr_accessible :kanji_id, :similar_id

  def secondary(main) main==kanji ? similar : kanji end
  def secondary_character(main) secondary(main).character end
  def secondary_meanings(main) secondary(main).meanings end
end
