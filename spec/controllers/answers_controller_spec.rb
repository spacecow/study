require 'spec_helper'

describe AnswersController do
  let(:quiz){ create :quiz }

  describe "#new" do
    let(:method){ get :new, quiz_id:quiz.id }
    let(:english){ "what's up?"  }
    let(:japanese){ "genki" }
    let(:mask){ "*****" }
    before{ create :sentence, english:english, japanese:japanese }

    it "creates a question" do
      expect{ method }.to change(Question, :count).from(0).to(1)
    end

    context "assigned question" do
      before{ method }
      subject{ assigns :question }
      its(:string){ should eq english }
      its(:correct){ should eq japanese }
    end

    context "assigned masked solution" do
      before{ method }
      subject{ assigns :solution }
      it{ should eq mask }
    end

  end

  describe "#create" do
    let(:question){ quiz.questions.create }
    let(:method){ post :create, answer:{
      quiz_id:quiz.id,
      question_id:question.id,
      string:'wow' }}

    it{ expect{ method }.to change(Answer, :count).from(0).to(1) }

    describe 'saved answer' do
      before{ method }
      subject{ Answer.last }
      its(:string){ should eq 'wow' }
    end

  end
end
