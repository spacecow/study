class AnswersController < ApplicationController
  
  def new
    quiz = Quiz.find params[:quiz_id]
    @question = quiz.questions.find(params[:question_id])
    @solution = @question.mask 
    @answer = quiz.answers.build
    @answer.question_id = @question.id
  end

  def create
    quiz = Quiz.find params[:answer].delete(:quiz_id)
    @question = Question.find params[:answer].delete(:question_id)
    if @question.correct == params[:answer]["string"]
      answer = quiz.answers.build params[:answer]
      answer.question_id = @question.id
      answer.save
      next_question_id = quiz.next_question_id(current_question_id:@question.id)
      redirect_to quiz and return if next_question_id.nil?
      redirect_to new_answer_url quiz_id:answer.quiz_id, question_id:next_question_id
    else
      @solution = @question.mask 
      @answer = quiz.answers.build
      @answer.question_id = @question.id
      render :new
    end
  end

end
