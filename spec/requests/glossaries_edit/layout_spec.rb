require 'spec_helper'

describe "Glossaries edit" do
  before(:each) do
    glossary = FactoryGirl.create(:glossary, japanese:'nomikomu', english:'gulp down')
    visit edit_glossary_path(glossary)
  end

  it "has a title" do
    page.should have_title('Edit Glossary')
  end

  it "has its english field filled in" do
    value('English').should eq 'gulp down' 
  end

  it "has its japanese field filled in" do
    value('Japanese').should eq 'nomikomu' 
  end

  it "has an update button" do
    page.should have_button('Update Glossary')
  end
end
