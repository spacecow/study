class Meaning < ActiveRecord::Base
  has_many :kanjis_meanings
  has_many :kanjis, :through => :kanjis_meanings

  attr_accessible :name
end
