class Project < ActiveRecord::Base
  has_many :sentences

  attr_accessible :name

  validates :name, presence:true, uniqueness:true
end
