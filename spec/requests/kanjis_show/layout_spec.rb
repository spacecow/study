# -*- coding: utf-8 -*-
require 'spec_helper' 

describe "Kanji show" do
  before(:each) do
    @kanji = FactoryGirl.create(:kanji, symbol:'魔')
  end

  context "without glossary" do
    before(:each) do
      visit kanji_path(@kanji)
    end

    it "has the kanji symbol in the title" do
      page.should have_title("魔")
    end

    it "displays no info as divs" do
      page.should_not have_div(:content)
    end

    it "has no sentence list" do
      page.should_not have_ul(:glossaries)
    end

    it "has no sentence list" do
      page.should_not have_bottom_links
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
