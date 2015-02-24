class Quiz < ActiveRecord::Base
  include QuizInstanceMethods
  has_many :answers
  has_many :questions

  def self.factory questionables:fail
    create.send :factory, questionables:questionables
  end

end
