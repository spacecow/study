require 'spec_helper' 

describe "Sentence show" do
  before(:each) do
    @sentence = FactoryGirl.create(:sentence, english:'The flood overwhelmed the village', japanese:'kouzui ga sono mura wo nomikonde shimatta')
  end


  context "with glossary" do
    before(:each) do
      @glossary = FactoryGirl.create(:glossary, content:'kouzui')
      @sentence.glossaries << @glossary
      visit sentence_path(@sentence)
    end

    it "has a glossary list" do
      page.should have_ul(:glossaries,0)
    end

    it "has a each glossary listed" do
      ul(:glossaries,0).lis_no(:glossary).should eq(1)
    end

    it "has each glossary listed as a link" do
      li(:glossary,0).span(:content,0).should have_link('kouzui')
      click_link 'kouzui'
      page.current_path.should eq glossary_path(@glossary)
    end
  end
end
