require "spec_helper"

describe "Sentence edit" do

  context "update" do
    let(:sentence){ create :sentence }

    it "" do
      glossary = create :glossary
      signin
      visit edit_sentence_path(sentence)
      fill_in 'Japanese', with:"updated japanese"
      fill_in 'Glossary', with:glossary.id
      click_button "Update Sentence"
      sentence = Sentence.last
      sentence.japanese.should eq "updated japanese"
      sentence.glossary_ids.should eq [glossary.id]
    end

  end

end

