module QuizInstanceMethods

  def next_question_id current_question_id:fail
    ids = question_ids
    index = ids.index(current_question_id)
    ids[index+1] if index
  end

end
