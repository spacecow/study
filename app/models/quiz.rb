class Quiz < ActiveRecord::Base
  include QuizInstanceMethods
  has_many :answers
  has_many :questions
end
