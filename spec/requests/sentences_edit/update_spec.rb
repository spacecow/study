require 'spec_helper'

describe "Sentence update" do
  context "update" do
    before(:each) do
      signin_member
      sentence = FactoryGirl.create(:sentence, english:'gulp down', japanese:'nomikomu')
      visit edit_sentence_path(sentence)
      fill_in 'English', with:'The flood overwhelmed the village'
      fill_in 'Japanese', with:'kouzui ga sono mura wo nomikonde shimatta'
    end

    context "sentence" do
      before(:each) do
        @sentence_count = Sentence.count
        click_button 'Update Sentence'
        @sentence = Sentence.last
      end

      it "adds no new sentence to the db" do
        Sentence.count.should eq @sentence_count
      end

      it "sets the english" do
        @sentence.english.should eq "The flood overwhelmed the village"
      end

      it "sets the japanese" do
        @sentence.japanese.should eq "kouzui ga sono mura wo nomikonde shimatta"
      end

      it "redirects to the new glossary page" do
        page.current_path.should eq sentences_path
      end
    end

    context "link to glossary" do
      before(:each) do
        glossary = FactoryGirl.create(:glossary)
        fill_in 'Glossary', with:glossary.id
        @lookup_count = Lookup.count
        click_button 'Update Sentence'
      end

      it "adds a lookup to the db" do
        Lookup.count.should eq @lookup_count+1
      end
    end
  end
end
