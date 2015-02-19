class Quiz < ActiveRecord::Base
  has_many :answers
  has_many :questions
end
