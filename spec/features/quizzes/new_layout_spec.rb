require 'spec_helper'

describe 'Quiz new layout' do
  let(:glossary){ create :glossary }
  let(:disdain){ create :glossary, content:"disdain" }
  let(:defiance){ create :glossary, content:"defiance" }
  let(:synonym_disdain){ create :synonym_glossary, glossary:glossary, synonym:disdain }
  let(:reverse_synonym_defiance){ create :synonym_glossary, glossary:defiance, synonym:glossary }
  before do
    signin_member
    sentence = create :sentence
    definition = create :definition, glossary:glossary, content:"contempt"
    create :lookup, sentence:sentence, definition:definition
    synonym_disdain
    reverse_synonym_defiance
    visit new_quiz_path
  end

  subject{ page.text }

  #context "no synonyms" do
  #  let(:synonym_disdain){ nil }
  #  it{ should include "contempt" }
  #  it{ should_not include "contempt; disdain" }
  #end

  #context "has synonyms" do
  #  let(:reverse_synonym_defiance){ nil }
  #  it{ should include "contempt; disdain" }
  #  it{ should_not include "contempt; disdain; defiance" }
  #end

  context "has two-way synonyms" do
    it{ should include "contempt; disdain; defiance" }
  end
end
