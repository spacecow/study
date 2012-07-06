require 'spec_helper'

describe "Sentence new" do
  before(:each) do
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
end
