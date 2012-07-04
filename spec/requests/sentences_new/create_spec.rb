require 'spec_helper'

describe "Glossaries new" do
  context "create" do
    before(:each) do
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

      it "redirects to the new glossary page" do
        page.current_path.should eq new_sentence_path
      end
    end

    context "link to glossary" do
      before(:each) do
        @glossary = FactoryGirl.create(:glossary)
        fill_in 'Glossary', with:@glossary.id
        @lookup_count = Lookup.count
        click_button 'Create Sentence'
        @lookup = Lookup.last
      end

      it "adds a lookup to the db" do
        Lookup.count.should eq @lookup_count+1
      end

      it "sets the glossary_id" do
        @lookup.glossary.should eq @glossary
      end

      it "sets the sentence_id" do
        @lookup.sentence.should eq Sentence.last
      end
    end
  end
end
