require 'spec_helper'

describe "Root index" do
  before(:each) do
    visit root_path
  end

  it "site nav lists glossaries" do
    site_nav.should have_link('Glossaries')
    click_link('Glossaries')
    page.current_path.should eq glossaries_path
  end
  it "site nav lists sentences" do
    site_nav.should have_link('Sentences')
    click_link('Sentences')
    page.current_path.should eq sentences_path
  end
end
