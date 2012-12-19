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
  end

  context "with sentences of chosen project" do
    before(:each) do
      @prince = FactoryGirl.create(:project, name:'Prince')
      FactoryGirl.create(:sentence, english:'The flood overwhelmed the village', japanese:'kouzui ga sono mura wo nomikonde shimatta', project:@prince)
      FactoryGirl.create(:sentence, english:'Whatever', japanese:'nandemonai')
      visit sentences_path
      select 'Prince', from:'Project'
      click_button 'Go'
    end

    it "has projects to select" do
      options('Project').should eq 'All, Prince, Factory Name'
    end

    it "has all sentences chosen" do
      selected_value('Project').should eq @prince.id.to_s
    end

    it "has a div for each sentence/glossary" do
      ul(:sentences,0).lis_no(:sentence).should eq(1)
    end
  end

  context "with sentences, without glossaries" do
    before(:each) do
      prince = FactoryGirl.create(:project, name:'Prince')
      @sentence = FactoryGirl.create(:sentence, english:'The flood overwhelmed the village', japanese:'kouzui ga sono mura wo nomikonde shimatta', project:prince)
      visit sentences_path
      select 'All', from:'Project'
      click_button 'Go'
    end

    it "has projects to select" do
      options('Project').should eq 'All, Prince'
    end

    it "has all sentences chosen" do
      selected_value('Project').should eq '0' 
    end

    it "has no glossaries list" do
      page.should_not have_ul(:glossaries,0)
    end
  end

  context "with sentences" do
    before(:each) do
      sentence = FactoryGirl.create(:sentence, english:'The flood overwhelmed the village', japanese:'kouzui ga sono mura wo nomikonde shimatta')
      @glossary = FactoryGirl.create(:glossary, content:'洪水', reading:'こうずい')
      @glossary.sentences << sentence
    end

    context ", glossaries & kanjis" do
      before(:each) do
        @kanji = FactoryGirl.create(:kanji, symbol:'洪')
        @glossary.kanjis << @kanji
        visit sentences_path
      end

      it "has a kanjis span" do
        span(:content,0).should have_ul(:kanjis,0)
      end

      it "has kanji displayed as a link to the kanji show page" do
        ul(:kanjis,0).should have_link('洪') 
        ul(:kanjis,0).span(:character,0).click_link('洪')
        page.current_path.should eq kanji_path(@kanji)
      end
    end
  end
end
