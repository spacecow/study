require 'spec_helper'

describe "Glossaries index" do
  context "without glossaries" do
    before(:each) do
      visit glossaries_path
    end

    it "has a title" do
      page.should have_title('Glossaries')
    end

    it "has no glossaries div" do
      page.should_not have_div(:glossaries)
    end

    it "has a link to the new sentence page" do
      page.should have_link('New Sentence')
      click_link 'New Sentence'
      page.current_path.should eq new_sentence_path
    end
  end

  context "with glossaries, without sentences" do
    before(:each) do
      @glossary = FactoryGirl.create(:glossary, english:'gulp down', japanese:'nomikomu')
      visit glossaries_path
    end

    it "has a glossaries div" do
      page.should have_div(:glossaries)
    end

    it "has a div for each glossary" do
      div(:glossaries).divs_no(:glossary).should eq(1)
    end

    it "has english displayed" do
      div(:glossaries).div(:glossary,0).div(:english).should have_content('gulp down') 
    end
    it "has no sentences div" do
      div(:glossaries).div(:glossary,0).should_not have_div(:sentences)
    end
  end

  context "with sentences" do
    before(:each) do
      glossary = FactoryGirl.create(:glossary)
      @sentence = FactoryGirl.create(:sentence, english:'The flood overwhelmed the village', japanese:'kouzui ga sono mura wo nomikonde shimatta')
      glossary.sentences << @sentence
      visit glossaries_path
    end

    it "has a sentences div" do
      div(:glossaries).div(:glossary,0).should have_div(:sentences)
    end

    it "has a div for each sentence" do
      div(:glossaries).div(:glossary,0).div(:sentences).divs_no(:sentence).should eq(1)
    end

    it "has english sentence displayed as a link" do
      div(:glossaries).div(:glossary,0).div(:sentences).div(:sentence,0).div(:english).should have_content('The flood overwhelmed the village')
      click_link('The flood overwhelmed the village')
      page.current_path.should eq edit_sentence_path(@sentence)
    end

    it "has japanese sentence displayed" do
      div(:glossaries).div(:glossary,0).div(:sentences).div(:sentence,0).div(:japanese).should have_content('kouzui ga sono mura wo nomikonde shimatta')
    end
  end
end
