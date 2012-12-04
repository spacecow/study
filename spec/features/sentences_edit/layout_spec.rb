require 'spec_helper'

describe "Sentence edit" do
  before(:each) do
    signin_member
    @project = FactoryGirl.create(:project, name:'Prince')
    sentence = FactoryGirl.create(:sentence, japanese:'kouzui ga sono mura wo nomikonde shimatta', english:'The flood overwhelmed the village', project:@project)
    visit edit_sentence_path(sentence)
  end

  it "has a title" do
    page.should have_title('Edit Sentence')
  end

  it "has its english field filled in" do
    value('English').should eq 'The flood overwhelmed the village' 
  end

  it "has its japanese field filled in" do
    value('Japanese').should eq 'kouzui ga sono mura wo nomikonde shimatta' 
  end

  it "has a glossary field" do
    value('Glossary').should be_nil 
  end

  it "has the project selected" do
    selected_value('Project').should eq @project.id.to_s
  end

  it "has an update button" do
    page.should have_button('Update Sentence')
  end
end
