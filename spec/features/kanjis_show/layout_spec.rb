# -*- coding: utf-8 -*-
require 'spec_helper' 

describe "Kanji show" do
  before(:each) do
    magic = FactoryGirl.create(:meaning, name:'magic')
    @kanji = FactoryGirl.create(:kanji, symbol:'魔')
    @kanji.meanings << magic
  end

  context "with glossaries" do
    before(:each) do
      @glossary = FactoryGirl.create(:glossary, content:'魔法')
      @kanji.glossaries << @glossary
      visit kanji_path(@kanji)
    end

    it "has a glossaries list" do
      page.should have_ul(:glossaries,0)
    end
  end
end
