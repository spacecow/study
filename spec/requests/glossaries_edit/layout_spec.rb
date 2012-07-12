require 'spec_helper'

describe "Glossary edit" do
  before(:each) do
    glossary = FactoryGirl.create(:glossary, content:'nomikomu')
    visit edit_glossary_path(glossary)
  end

  it "has a title" do
    page.should have_title('Edit Glossary')
  end

  it "has its content field filled in" do
    value('Content').should eq 'nomikomu' 
  end

  it "has no sentence field" do
    value('Sentence').should be_nil
  end

  it "has an update button" do
    page.should have_button('Update Glossary')
  end
end
