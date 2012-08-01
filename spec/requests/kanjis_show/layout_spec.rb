# -*- coding: utf-8 -*-
require 'spec_helper' 

describe "Kanji show" do
  before(:each) do
    magic = FactoryGirl.create(:meaning)
    @kanji = FactoryGirl.create(:kanji, symbol:'魔')
  end

  context "no user, without glossary, without similars" do
    before(:each) do
      visit kanji_path(@kanji)
    end

    it "has the kanji symbol in the title" do
      page.should have_title("魔")
    end

    it "displays meaning info as divs" do
      page.should have_div(:meanings)
    end

    it "has no sentence list" do
      page.should_not have_ul(:glossaries)
    end

    it "has no similars div" do
      page.should_not have_ul(:similars)
    end

    it "has no edit link" do
      bottom_links.should_not have_link('Edit')
    end
  end

  context "user logged in" do
    it "has an edit link" do
      signin_member
      visit kanji_path(@kanji)
      bottom_links.should have_link('Edit')
      click_link 'Edit' 
      page.current_path.should eq edit_kanji_path(@kanji)
    end
  end

  context "without glossary, with similars" do
    before(:each) do
      @demon = FactoryGirl.create(:kanji, symbol:'鬼') 
      @kanji.similars << @demon
      visit kanji_path(@kanji)
    end

    it "has a similars div" do
      page.should have_ul(:similars)
    end

    it "has a div for each similar" do
      ul(:similars).lis_no(:similar).should be(1)
    end

    it "has each similar listed as a link" do
      li(:similar,0).span(:kanji).should have_link('鬼')
      click_link '鬼'
      page.current_path.should eq kanji_path(@demon)
    end
  end

  context "with glossaries" do
    before(:each) do
      @glossary = FactoryGirl.create(:glossary, content:'魔法')
      @kanji.glossaries << @glossary
      visit kanji_path(@kanji)
    end

    it "has a glossaries list" do
      page.should have_ul(:glossaries)
    end
  end
end
