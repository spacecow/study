require 'spec_helper'

describe "Glossaries edit" do
  context "update" do
    before(:each) do
      glossary = FactoryGirl.create(:glossary, english:'gulp down', japanese:'nomikomu')
      visit edit_glossary_path(glossary)
      @glossary_count = Glossary.count
      fill_in 'English', with:'japanese'
      fill_in 'Japanese', with:'nihongo'
      click_button 'Update Glossary'
      @glossary = Glossary.last
    end

    it "adds no new glossary to the db" do
      Glossary.count.should eq @glossary_count
    end

    it "sets the english" do
      @glossary.english.should eq "japanese"
    end
    it "sets the japanese" do
      @glossary.japanese.should eq "nihongo"
    end

    it "redirects to the new glossary page" do
      page.current_path.should eq glossaries_path
    end
  end
end
