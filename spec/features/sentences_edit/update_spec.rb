require "spec_helper"

describe "Sentence edit" do

  context "update" do
    let(:sentence){ create :sentence }

    it "" do
      definition = create :definition
      signin
      visit edit_sentence_path(sentence)
      fill_in 'Japanese', with:"updated japanese"
      fill_in 'Glossary', with:definition.id
      click_button "Update Sentence"
      sentence = Sentence.last
      sentence.japanese.should eq "updated japanese"
      sentence.definition_ids.should eq [definition.id]
    end

  end

end

