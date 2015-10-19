module QuizInstanceMethods

  def next_question_id current_question_id:fail
    ids = question_ids
    index = ids.index(current_question_id)
    ids[index+1] if index
  end

  private 

    def factory questionables:fail
      tap do |quiz|
        questionables.each do |q|
          qparams = q.question_params
          string = Masker.combine qparams.map{|e| e[:string]}
          qparams.each do |params|
            quiz.questions.create params.merge({string:string})
          end
        end
      end
    end

end
