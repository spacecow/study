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

    it "has no link to the new glossary page" do
      page.should_not have_bottom_link('New Glossary')
    end
  end

  context "with glossaries, without sentences" do
    before(:each) do
      @glossary = FactoryGirl.create(:glossary, content:'nomikomu')
      visit glossaries_path
    end

    it "has a glossaries div" do
      page.should have_div(:glossaries)
    end

    it "has a div for each glossary/sentence" do
      div(:glossaries).divs_no(:glossary_container).should eq(1)
    end

    it "has a div for the glossary" do
      div(:glossary_container,0).should have_div(:glossary)
    end

    it "has content displayed as a link" do
      div(:glossary).div(:content).should have_link('nomikomu') 
      click_link('nomikomu')
      page.current_path.should eq glossary_path(@glossary)
    end

    it "has no sentences list" do
      div(:glossary_container,0).should_not have_ul(:sentences)
    end
  end

  context "with glossaries & sentences" do
    before(:each) do
      glossary = FactoryGirl.create(:glossary)
      @sentence = FactoryGirl.create(:sentence, english:'The flood overwhelmed the village', japanese:'kouzui ga sono mura wo nomikonde shimatta')
      glossary.sentences << @sentence
      visit glossaries_path
    end

    it "has a sentences list" do
      div(:glossary_container,0).should have_ul(:sentences)
    end

    it "has a div for each sentence" do
      ul(:sentences).lis_no(:sentence).should eq(1)
    end

    it "has english sentence displayed as a link" do
      li(:sentence,0).div(:english).should have_content('The flood overwhelmed the village')
      click_link('The flood overwhelmed the village')
      page.current_path.should eq sentence_path(@sentence)
    end

    it "has japanese sentence displayed as a link" do
      li(:sentence,0).div(:japanese).should have_content('kouzui ga sono mura wo nomikonde shimatta')
      click_link('kouzui ga sono mura wo nomikonde shimatta')
      page.current_path.should eq sentence_path(@sentence)
    end
  end
end
