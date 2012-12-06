# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Glossary" do
  context "update" do
    before(:each) do
      glossary = FactoryGirl.create(:glossary, content:'飲み込む', reading:'のみこむ')
      signin_member
      visit edit_glossary_path(glossary)
      fill_in 'Content', with:'日本語'
      fill_in 'Reading', with:'にほんご'
    end

    context "glossary" do
      before(:each) do
        @glossary_count = Glossary.count
        click_button 'Update Glossary'
        @glossary = Glossary.last
      end

      it "adds no new glossary to the db" do
        Glossary.count.should eq @glossary_count
      end

      it "sets the glossary content" do
        @glossary.content.should eq "日本語"
      end
      it "sets the glossary reading" do
        @glossary.reading.should eq "にほんご"
      end

      it "redirects to the glossaries index" do
        page.current_path.should eq glossary_path(@glossary)
      end
    end

    context "link to sentence" do
      before(:each) do
        @sentence = FactoryGirl.create(:sentence)
        fill_in 'Sentence', with:@sentence.id
        @lookup_count = Lookup.count
        click_button 'Update Glossary'
        @lookup = Lookup.last
      end

      it "adds a lookup to the db" do
        Lookup.count.should eq @lookup_count+1
      end
    end
  end
end
