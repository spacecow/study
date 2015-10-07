class QuizzesController < ApplicationController
  
  def show
  end

  def new
    quiz = Quiz.factory questionables:
      Sentence.all
    redirect_to new_answer_url(quiz_id:quiz.id, question_id:quiz.questions.first.id)
  end

  def create
    render :new
  end 
end
