require 'spec_helper' 

describe "Glossary show" do
  before(:each) do
    @glossary = FactoryGirl.create(:glossary, english:'flood', japanese:'kouzui')
  end

  context "without glossary" do
    before(:each) do
      visit glossary_path(@glossary)
    end

    it "has the glossary info in the title" do
      page.should have_title("kouzui")
      page.should have_subtitle("flood")
    end

    it "displays no info as divs" do
      page.should_not have_div(:english)
      page.should_not have_div(:japanese)
    end

    it "has no sentence list" do
      page.should_not have_ul(:sentences)
    end

    it "has an edit link" do
      page.should have_link('Edit')
      click_link 'Edit'
      page.current_path.should eq edit_glossary_path(@glossary)
    end
  end

  context "with sentences" do
    before(:each) do
      @sentence = FactoryGirl.create(:sentence, english:'The flood overwhelmed the village', japanese:'kouzui ga sono mura wo nomikonde shimatta')
      @glossary.sentences << @sentence
      visit glossary_path(@glossary)
    end

    it "has a sentence list" do
      page.should have_ul(:sentences)
    end

    it "has a each glossary listed" do
      ul(:sentences).lis_no(:sentence).should eq(1)
    end

    it "has each japanese sentence listed as a link" do
      li(:sentence,0).div(:japanese).should have_link('kouzui ga sono mura wo nomikonde shimatta')
      click_link 'kouzui ga sono mura wo nomikonde shimatta'
      page.current_path.should eq sentence_path(@sentence)
    end

    it "has each english sentence listed as a link" do
      li(:sentence,0).div(:english).should have_link('The flood overwhelmed the village')
      click_link 'The flood overwhelmed the village'
      page.current_path.should eq sentence_path(@sentence)
    end
  end
end
