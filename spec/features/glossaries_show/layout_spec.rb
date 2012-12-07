require 'spec_helper' 

describe "Glossary show" do
  before(:each) do
    @glossary = FactoryGirl.create(:glossary, content:'kouzui')
  end

  context "with sentences" do
    before(:each) do
      @sentence = FactoryGirl.create(:sentence, english:'The flood overwhelmed the village', japanese:'kouzui ga sono mura wo nomikonde shimatta')
      @glossary.sentences << @sentence
      visit glossary_path(@glossary)
    end

    it "has each japanese sentence listed as a link" do
      li(:sentence,0).div(:japanese).should have_link('kouzui ga sono mura wo nomikonde shimatta')
      click_link 'kouzui ga sono mura wo nomikonde shimatta'
      page.current_path.should eq sentence_path(@sentence)
    end

    it "has each english sentence listed as a link" do
      li(:sentence,0).div(:english).should have_link('The flood overwhelmed the village')
      click_link 'The flood overwhelmed the village'
      page.current_path.should eq sentence_path(@sentence)
    end
  end
end
