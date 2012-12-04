# -*- coding: utf-8 -*-
require 'spec_helper'

describe Glossary do
  describe "#ids_from_tokens" do
    context "string of ids" do
      it{ Glossary.ids_from_tokens("1,2").should eq %w(1 2) }
    end

    context "new glossary" do
      it{ Glossary.ids_from_tokens("<<<cat>>>").should eq [Glossary.last.id.to_s] }
    end

    context "existing glossary" do
      before{ create :glossary, content:'cat' }
      it{ lambda{ Glossary.ids_from_tokens("<<<cat>>>")}.should raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Content has already been taken')}
    end
  end
end

describe Glossary do
  describe "#kanji_array" do
    it "gets the kanjis in an array" do
      FactoryGirl.create(:kanji, symbol:'魔') 
      FactoryGirl.create(:kanji, symbol:'法') 
      glossary = FactoryGirl.create(:glossary, content:'魔法') 
      glossary.kanji_array.should eq ['魔','法']
    end

    it "skips characters that are not in the db" do
      FactoryGirl.create(:kanji, symbol:'法') 
      glossary = FactoryGirl.create(:glossary, content:'魔法') 
      glossary.kanji_array.should eq ['法']
    end
  end

  describe "#link_to_kanjis" do
    before(:each) do
      @kanji = FactoryGirl.create(:kanji, symbol:'法') 
      @glossary = FactoryGirl.create(:glossary, content:'魔法') 
    end

    it "adds link between glossary and kanji to db" do
      lambda{ @glossary.link_to_kanjis
      }.should change(GlossariesKanji, :count).by(1)
    end

    it "adds link between Glossary and kanji to db" do
      lambda{ Glossary.link_to_kanjis
      }.should change(GlossariesKanji, :count).by(1)
    end

    it "add no links if links already exists" do
      @kanji.glossaries << @glossary
      lambda{ @glossary.link_to_kanjis
      }.should change(GlossariesKanji, :count).by(0)
    end
  end
end
