# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Sentences index" do
  context "no user, without sentences" do
    before(:each) do
      visit sentences_path
    end

    it "has no projects to select" do
      options('Project').should eq 'All'
    end

    it "has all sentences chosen" do
      selected_value('Project').should eq '0' 
    end

    it "has a title" do
      page.should have_title('Sentences')
    end

    it "has no glossaries div" do
      page.should_not have_div(:sentences)
    end

    it "has no link to the new sentence page" do
      page.should_not have_link('New Sentence')
    end
  end

  context "signed in user, without sentences" do
    before(:each) do
      signin_member
      visit sentences_path
    end

    it "has a link to the new sentence page" do
      page.should have_link('New Sentence')
      click_link 'New Sentence'
      page.current_path.should eq new_sentence_path
    end
  end

  context "with sentences of right project" do
    before(:each) do
      @prince = FactoryGirl.create(:project, name:'Prince')
      FactoryGirl.create(:sentence, english:'The flood overwhelmed the village', japanese:'kouzui ga sono mura wo nomikonde shimatta', project:@prince)
      FactoryGirl.create(:sentence, english:'Whatever', japanese:'nandemonai')
      visit sentences_path(project:@prince.id)
    end

    it "has projects to select" do
      options('Project').should eq 'All, Prince, Factory Name'
    end

    it "has all sentences chosen" do
      selected_value('Project').should eq @prince.id.to_s
    end

    it "has a div for each sentence/glossary" do
      div(:sentences).divs_no(:sentence_container).should eq(1)
    end
  end

  context "with sentences, without glossaries" do
    before(:each) do
      prince = FactoryGirl.create(:project, name:'Prince')
      @sentence = FactoryGirl.create(:sentence, english:'The flood overwhelmed the village', japanese:'kouzui ga sono mura wo nomikonde shimatta', project:prince)
      visit sentences_path
    end

    it "has projects to select" do
      options('Project').should eq 'All, Prince'
    end

    it "has all sentences chosen" do
      selected_value('Project').should eq '0' 
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
      @glossary = FactoryGirl.create(:glossary, content:'洪水', reading:'こうずい')
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
        li(:glossary,0).div(:content).should have_content('洪水(こうずい)')
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
