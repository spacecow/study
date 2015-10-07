require 'spec_helper'

describe QuizzesController do

  describe "#new" do
    let(:method){ get :new }
    before do
      project = create :project
      create :sentence, project:project, english:'huh'
      create :sentence, project:project, english:'yeah'
    end

    it "creates a quiz" do
      expect{ method }.to change(Quiz, :count).from(0).to(1)
    end

    it "creates a questions for each sentence" do
      expect{ method }.to change(Question, :count).from(0).to(2)
    end

  end
end
