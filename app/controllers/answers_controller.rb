class AnswersController < ApplicationController
  
  def new
    quiz = Quiz.find params[:quiz_id]
    @question = quiz.questions.create(Sentence.first.question_params)
    @solution = @question.mask 
    @answer = quiz.answers.build
    @answer.question_id = @question.id
  end

  def create
    quiz = Quiz.find params[:answer].delete(:quiz_id)
    question = Question.find params[:answer].delete(:question_id)
    answer = quiz.answers.build params[:answer]
    answer.question_id = question.id
    answer.save
    redirect_to new_answer_url quiz_id:answer.quiz_id
  end

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

