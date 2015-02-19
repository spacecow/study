class QuizesController < ApplicationController
  
  def new
    sentence = Sentence.first
    @question = sentence.english 
    @correct = sentence.japanese 
    @solution = "*"*@correct.length 
  end
  
  def create
    sentence = Sentence.first
    @question = sentence.english 
    @correct = sentence.japanese 
    @solution = "*"*@correct.length 
    render :new
  end

end
