class QuizzesController < ApplicationController
  
  def show
  end

  def new
    quiz = Quiz.create
    Sentence.all.each do |sentence|
      quiz.questions.create sentence.question_params
    end
    redirect_to new_answer_url(quiz_id:quiz.id, question_id:quiz.questions.first.id)
  end

  def create
    render :new
  end 
end
