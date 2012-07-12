require 'spec_helper' 

describe "Sentence show" do
  before(:each) do
    @sentence = FactoryGirl.create(:sentence, english:'The flood overwhelmed the village', japanese:'kouzui ga sono mura wo nomikonde shimatta')
  end

  context "without glossary" do
    before(:each) do
      visit sentence_path(@sentence)
    end

    it "has the glossary info in the title" do
      page.should have_title("kouzui ga sono mura wo nomikonde shimatta")
      page.should have_subtitle("The flood overwhelmed the village")
    end

    it "displays no info as divs" do
      page.should_not have_div(:english)
      page.should_not have_div(:japanese)
    end

    it "has no glossary list" do
      page.should_not have_ul(:glossaries)
    end

    it "has an edit link" do
      page.should have_link('Edit')
      click_link 'Edit'
      page.current_path.should eq edit_sentence_path(@sentence)
    end
  end

  context "with glossary" do
    before(:each) do
      @glossary = FactoryGirl.create(:glossary, content:'kouzui')
      @sentence.glossaries << @glossary
      visit sentence_path(@sentence)
    end

    it "has a glossary list" do
      page.should have_ul(:glossaries)
    end

    it "has a each glossary listed" do
      ul(:glossaries).lis_no(:glossary).should eq(1)
    end

    it "has each glossary listed as a link" do
      li(:glossary,0).div(:content).should have_link('kouzui')
      click_link 'kouzui'
      page.current_path.should eq glossary_path(@glossary)
    end
  end
end
