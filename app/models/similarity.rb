class Similarity < ActiveRecord::Base
  belongs_to :kanji
  belongs_to :similar, :class_name => 'Kanji'

  attr_accessible :kanji_id, :similar_id
end
