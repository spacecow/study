# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Sentence new" do
  context "create" do
    before(:each) do
      FactoryGirl.create(:project)
      @user = create_member
      signin
      visit new_sentence_path
      fill_in 'Japanese', with:'kouzui ga sono mura wo nomikonde shimatta'
      fill_in 'English', with:'The flood overwhelmed the village'
    end

    context "sentence" do
      before(:each) do
        @sentence_count = Sentence.count
        click_button 'Create Sentence'
        @sentence = Sentence.last
      end

      it "adds a glossary to the db" do
        Sentence.count.should eq @sentence_count+1
      end

      it "sets the english" do
        @sentence.english.should eq "The flood overwhelmed the village"
      end

      it "sets the japanese" do
        @sentence.japanese.should eq "kouzui ga sono mura wo nomikonde shimatta"
      end

      it "sets the link to the current user" do
        @sentence.owner.should eq @user
      end

      it "redirects to that sentence page" do
        page.current_path.should eq sentence_path(@sentence)
      end
    end

    context "link to" do
      before(:each) do
        FactoryGirl.create(:kanji, symbol:'魔')
        @glossarieskanji_count = GlossariesKanji.count
      end

      context "new glossary" do
        before(:each) do
          fill_in 'Glossary', with:'<<<魔法>>>'
          @lookup_count = Lookup.count
          @definition_count = Glossary.count
          click_button 'Create Sentence'
          @lookup = Lookup.last
          @definition = Definition.last
        end

        it "adds a glossary to the db" do
          Definition.count.should eq @definition_count+1
        end
        it "adds a lookup to the db" do
          Lookup.count.should eq @lookup_count+1
        end

        it "sets the definition_id" do
          @lookup.definition.should eq @definition
        end
        it "sets the sentence_id" do
          @lookup.sentence.should eq Sentence.last
        end
      end

      context "existing glossary" do
        before(:each) do
          glossary = create :glossary, content:'魔法'
          @definition = create :definition, glossary:glossary
          fill_in 'Glossary', with:@definition.id
          @lookup_count = Lookup.count
          click_button 'Create Sentence'
          @lookup = Lookup.last
        end

        it "adds a lookup to the db" do
          Lookup.count.should eq @lookup_count+1
        end

        it "sets the definition_id" do
          @lookup.definition.should eq @definition
        end

        it "sets the sentence_id" do
          @lookup.sentence.should eq Sentence.last
        end
      end

      after(:each) do
        GlossariesKanji.count.should eq @glossarieskanji_count+1
      end
    end
  end
end
