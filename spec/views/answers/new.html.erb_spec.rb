require 'capybara'

module Jerb
  class Binding
    def initialize hash = {}
      hash.each do |key,val|
        singleton_class.send(:define_method,key){ val }
      end
    end
    def get; binding end
  end

  class Form
    attr_accessor :object
    def initialize obj
      self.object = obj
    end
    def hidden_field s 
      "<input id='answer_#{s}' type='hidden' value='#{object.public_send s}'></input>"
    end
    def text_field s, options={}
      "<input id='answer_#{s}' type='text' value='#{object.public_send s}'></input>"
    end
    def submit s
    end
  end
end

describe 'answers/new.html.erb' do
  
  let(:filepath){ File.expand_path '../../../../app/views/answers/new.html.erb', __FILE__ } 
  let(:file){ File.read(filepath).gsub(/%= form/,'% form') }
  let(:erb){ ERB.new file }
  let(:erb_binding){ Jerb::Binding.new }
  let(:local_bindings){ erb_binding.get }
  let(:rendered){ erb.result local_bindings }

  let(:answer){ double(:answer).as_null_object }
  let(:question){ double(:question).as_null_object }
  let(:form){ Jerb::Form.new answer }

  let(:quiz_id){ 666 }
  let(:question_id){ 888 }
  let(:answer_string){ 'yeah' }
  let(:question_string){ 'What is 1+1?' }
  let(:correct){ '2' }
  let(:solution){ '*' }

  before do
    def erb_binding.form_for obj; end
    erb_binding.should_receive(:form_for).and_yield form
    erb_binding.instance_variable_set "@question",question
    erb_binding.instance_variable_set "@solution",solution
  end

  subject(:doc){ Capybara.string rendered }

  describe 'Question' do
    before{ question.should_receive(:string){ question_string }}
    subject{ doc.find '#question' }
    its(:text){ should eq question_string }
  end

  describe 'Correct' do
    before{ question.should_receive(:correct){ correct }}
    subject{ doc.find '#correct' }
    its(:text){ should eq correct }
    its([:class]){ should eq "white" }
  end

  describe 'Solution' do
    subject{ doc.find '#solution' }
    its(:text){ should eq solution }
  end

  describe 'Quiz id' do
    before{ answer.should_receive(:quiz_id){ quiz_id }}
    subject{ doc.find '#answer_quiz_id' }
    its(:value){ should eq quiz_id.to_s }
    its([:type]){ should eq "hidden" }
  end

  describe 'Question id' do
    before{ answer.should_receive(:question_id){ question_id }}
    subject{ doc.find '#answer_question_id' }
    its(:value){ should eq question_id.to_s }
    its([:type]){ should eq "hidden" }
  end

  describe 'Answer' do
    before{ answer.should_receive(:string){ answer_string }}
    subject{ doc.find '#answer_string' }
    its(:value){ should eq answer_string }
    its([:type]){ should eq "text" }
  end

end
