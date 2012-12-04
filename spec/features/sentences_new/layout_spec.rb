require 'spec_helper'

describe "Sentence new" do
  context "without prior sentences" do
    before(:each) do
      signin_member
      @project = FactoryGirl.create(:project)
      visit new_sentence_path
    end

    it "has a title" do
      page.should have_title('New Sentence')
    end

    it "has a field for japanese" do
      value('Japanese').should be_nil
    end
    it "has a field for english" do
      value('English').should be_nil
    end
    it "has a field for glossary tokens" do
      value('Glossary').should be_nil
    end
    it "has the only project selected" do
      selected_value('Project').should eq @project.id.to_s 
    end
  end

  context "with prior sentences" do
    before(:each) do
      member = signin_member
      FactoryGirl.create(:project, name:'Prince')
      @project = FactoryGirl.create(:project, name:'alc')
      FactoryGirl.create(:sentence, project:@project, user:member)
      visit new_sentence_path
    end

    it "has the previous project selected" do
      selected_value('Project').should eq @project.id.to_s 
    end
  end
end
