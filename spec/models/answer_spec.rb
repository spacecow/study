require 'spec_helper'

describe Answer do

  describe "create" do
    
    it "quiz id cannot be blank" do
      quiz = create :quiz 
      question = quiz.questions.create
      expect{question.create_answer}.to raise_error{|e|
        expect(e).to be_a ActiveRecord::StatementInvalid 
        expect(e.message).to match /'quiz_id' cannot be null/ }
    end

    it "question id cannot be blank" do
      quiz = create :quiz 
      expect{quiz.answers.create}.to raise_error{|e|
        expect(e).to be_a ActiveRecord::StatementInvalid 
        expect(e.message).to match /'question_id' cannot be null/ }
    end

  end
end
