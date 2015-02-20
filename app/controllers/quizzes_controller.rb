class QuizzesController < ApplicationController
  
  def new
    quiz = Quiz.create
    redirect_to new_answer_url(quiz_id:quiz.id)
  end

  def create
    render :new
  end 
end
