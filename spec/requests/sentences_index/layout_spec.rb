require 'spec_helper'

describe "Sentences index" do
  context "without sentences" do
    before(:each) do
      visit sentences_path
    end

    it "has a title" do
      page.should have_title('Sentences')
    end

    it "has no glossaries div" do
      page.should_not have_div(:sentences)
    end

    it "has a link to the new sentence page" do
      page.should have_link('New Sentence')
      click_link 'New Sentence'
      page.current_path.should eq new_sentence_path
    end
  end

  context "with sentences, without glossaries" do
    before(:each) do
      @sentence = FactoryGirl.create(:sentence, english:'The flood overwhelmed the village', japanese:'kouzui ga sono mura wo nomikonde shimatta')
      visit sentences_path
    end

    it "has a sentences div" do
      page.should have_div(:sentences)
    end

    it "has a div for each sentence" do
      div(:sentences).divs_no(:sentence).should eq(1)
    end

    it "has english displayed" do
      div(:sentences).div(:sentence,0).div(:english).should have_content('The flood overwhelmed the village') 
    end
    it "has japanese displayed as a link to its edit page" do
      div(:sentences).div(:sentence,0).div(:japanese).should have_link('kouzui ga sono mura wo nomikonde shimatta') 
      click_link('kouzui ga sono mura wo nomikonde shimatta')
      page.current_path.should eq edit_sentence_path(@sentence)
    end

    it "has no glossaries list" do
      div(:sentences).div(:sentence,0).should_not have_list(:glossaries)
    end
  end

  context "with sentences & glossaries" do
    before(:each) do
      sentence = FactoryGirl.create(:sentence, english:'The flood overwhelmed the village', japanese:'kouzui ga sono mura wo nomikonde shimatta')
      @glossary = FactoryGirl.create(:glossary, japanese:'kouzui')
      @glossary.sentences << sentence
      visit sentences_path
    end

    it "has a glossaries list" do
      div(:sentences).div(:sentence,0).should have_list(:glossaries)
    end

    it "has a each glossary listed" do
      div(:sentences).div(:sentence,0).ul(:glossaries).lis_no(:glossary).should eq(1)
    end

    it "has each glossary listed as a link" do
      div(:sentences).div(:sentence,0).ul(:glossaries).li(:glossary,0).div(:japanese).should have_link('kouzui')
      click_link 'kouzui'
      page.current_path.should eq edit_glossary_path(@glossary)
    end
  end
end
