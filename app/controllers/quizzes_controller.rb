class QuizzesController < ApplicationController
  
  def new
    quiz = Quiz.create
    redirect_to new_answer_url(quiz_id:quiz.id)
  end

  def create
    render :new
  end 

  #def new
  #  sentence = Sentence.first
  #  @question = sentence.english 
  #  @correct = sentence.japanese 
  #  @solution = "*"*@correct.length 
  #end
  #
  #def create
  #  sentence = Sentence.first
  #  @question = sentence.english 
  #  @correct = sentence.japanese 
  #  @solution = "*"*@correct.length 
  #  render :new
  #end

end
