require File.expand_path '../../../app/strategies/quiz_instance_methods', __FILE__

class Fitta
  include QuizInstanceMethods
end

describe QuizInstanceMethods do
  let(:quiz){ Fitta.new }

  describe "#next_question_id" do
    let(:question_ids){ [666,888] }
    let(:current_id){ 666 }
    before{ quiz.should_receive(:question_ids){ question_ids }}
    subject{ quiz.next_question_id current_question_id:current_id }

    context "a next question exists" do
      it{ should eq 888 }
    end

    context "a next question does not exists" do
      let(:question_ids){ [666] }
      it{ should be_nil }
    end

    context "current question does not exists" do
      let(:current_id){ 665 }
      it{ should be_nil }
    end

    context "current question is nil" do
      let(:current_id){ nil }
      it{ should be_nil }
    end
  end

  describe "#factory" do
    let(:questions){ double :questions }
    let(:elem){ double :elem }
    let(:arr){ [elem] }
    before do
      quiz.should_receive(:questions){ questions }
      questions.should_receive(:create).with(:params)
      elem.should_receive(:question_params){ [:params] }
    end
    subject{ quiz.send :factory, questionables:arr }
    it{ should eq quiz }
  end

end
