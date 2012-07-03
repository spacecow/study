require 'spec_helper'

describe "Glossaries new" do
  before(:each) do
    visit new_glossary_path
  end

  it "has a title" do
    page.should have_title('New Glossary')
  end

  it "has a field for japanese" do
    value('Japanese').should be_nil
  end
end
