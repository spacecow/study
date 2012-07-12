# -*- coding: utf-8 -*-
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

    it "has a div for each sentence/glossary" do
      div(:sentences).divs_no(:sentence_container).should eq(1)
    end

    it "has a div for the sentence" do
      div(:sentence_container,0).should have_div(:sentence)
    end

    it "has english displayed as a link" do
      div(:sentence).div(:english).should have_content('The flood overwhelmed the village') 
      click_link('The flood overwhelmed the village')
      page.current_path.should eq sentence_path(@sentence)
    end

    it "has japanese displayed as a link" do
      div(:sentence).div(:japanese).should have_link('kouzui ga sono mura wo nomikonde shimatta') 
      click_link('kouzui ga sono mura wo nomikonde shimatta')
      page.current_path.should eq sentence_path(@sentence)
    end

    it "has no glossaries list" do
      div(:sentence_container,0).should_not have_ul(:glossaries)
    end
  end

  context "with sentences" do
    before(:each) do
      sentence = FactoryGirl.create(:sentence, english:'The flood overwhelmed the village', japanese:'kouzui ga sono mura wo nomikonde shimatta')
      @glossary = FactoryGirl.create(:glossary, content:'洪水')
      @glossary.sentences << sentence
    end

    context "& glossaries" do
      before(:each) do
        visit sentences_path
      end

      it "has a glossaries list" do
        div(:sentence_container,0).should have_ul(:glossaries)
      end

      it "has a div for each glossary" do
        ul(:glossaries).lis_no(:glossary).should eq(1)
      end

      it "has japanese glossary displayed as a link" do
        li(:glossary,0).div(:content).should have_content('洪水')
        click_link('洪水')
        page.current_path.should eq glossary_path(@glossary)
      end

      it "has no kanjis span" do
        div(:content).should_not have_span("kanjis")
      end
    end

    context ", glossaries & kanjis" do
      before(:each) do
        @kanji = FactoryGirl.create(:kanji, symbol:'洪')
        @glossary.kanjis << @kanji
        visit sentences_path
      end

      it "has a kanjis span" do
        div(:content).should have_span("kanjis")
      end

      it "has kanji displayed as a link to the kanji show page" do
        span(:kanjis).should have_link('洪') 
        click_link('洪')
        page.current_path.should eq kanji_path(@kanji)
      end
    end
  end
end
