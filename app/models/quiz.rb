class Quiz < ActiveRecord::Base
  has_many :answers
  has_many :questions

  def next_question_id current_question_id:fail
    index = question_ids.index(current_question_id)
    question_ids[index+1]
  end
end
