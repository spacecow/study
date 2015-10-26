require "spec_helper"

describe "Sentence update" do
  
  it "" do
    signin
    glossary = create :glossary
    disdain = create :glossary, content:"disdain"
    snobbery = create :glossary, content:"snobbery"
    love = create :glossary, content:"love"
    visit edit_glossary_path(glossary)
    fill_in "Content", with:"contempt"
    fill_in "Synonyms", with:disdain.id
    fill_in "Similars", with:snobbery.id
    fill_in "Antonyms", with:love.id
    synonym_count = SynonymGlossary.count
    similar_count = SimilarGlossary.count
    antonym_count = AntonymGlossary.count
    click_button "Update Glossary" 

    page.text.should include "contempt"
    page.text.should include "disdain"
    page.text.should include "snobbery"
    page.text.should include "love"
    SynonymGlossary.count.should eq synonym_count+1
    SimilarGlossary.count.should eq similar_count+1
    AntonymGlossary.count.should eq antonym_count+1
  end

end
