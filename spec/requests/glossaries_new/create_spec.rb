require 'spec_helper'

describe "Glossaries new" do
  context "create" do
    before(:each) do
      visit new_glossary_path
      fill_in 'Japanese', with:'nihongo'
      @glossary_count = Glossary.count
      click_button 'Create Glossary'
    end

    it "adds a glossary to the db" do
      Glossary.count.should eq @glossary_count+1
    end

    it "sets the japanese" do
      Glossary.last.japanese.should eq "nihongo"
    end

    it "redirects to the new glossary page" do
      page.current_path.should eq new_glossary_path
    end
  end
end
