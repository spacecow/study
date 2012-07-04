require 'spec_helper'

describe "Sentence update" do
  context "update" do
    before(:each) do
      sentence = FactoryGirl.create(:sentence, english:'gulp down', japanese:'nomikomu')
      visit edit_sentence_path(sentence)
      @sentence_count = Sentence.count
      fill_in 'English', with:'The flood overwhelmed the village'
      fill_in 'Japanese', with:'kouzui ga sono mura wo nomikonde shimatta'
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
end
