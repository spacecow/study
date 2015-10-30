require 'spec_helper' 

describe "display sentence" do

  let(:sentence){ create :sentence,
    english:"The flood overwhelmed the village",
    japanese:"kouzui ga sono mura wo nomikonde shimatta" }
  let(:lookup){ create :lookup, sentence:sentence, definition:definition }
  let(:definition){ create :definition,
    content:'to overwhelm', glossary:glossary }
  let(:glossary){ create :glossary, content:"nomikomu" } 

  before do
    signin_admin
    lookup
    visit sentence_path(sentence)
  end

  subject{ page }

  it "with glossary" do
    page.text.should include "The flood overwhelmed the village"
    page.text.should include "kouzui ga sono mura wo nomikonde shimatta"
    page.text.should include 'to overwhelm'
  end

  context "edit definition" do
    before{ click_link 'to overwhelm' }
    its(:current_path){ should eq edit_definition_path(definition) }
  end

  context "show glossary" do
    before{ click_link 'nomikomu' }
    its(:current_path){ should eq glossary_path(glossary) }
  end

  context "edit glossary" do
    before{ click_link 'Edit Glossary' }
    its(:current_path){ should eq edit_glossary_path(glossary) }
  end

  context "edit sentence" do
    before{ click_link 'Edit Sentence' }
    its(:current_path){ should eq edit_sentence_path(sentence) }
  end

end
