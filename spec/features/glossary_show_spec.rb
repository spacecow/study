require 'spec_helper'

describe 'Glossary show' do
  let(:manticora){ create :glossary, content:'manticora' }

  context "synonyms" do
    let(:pegasus){ create :glossary, content:'pegasus'}
    let(:definition_manticora){ create :definition, glossary:manticora }
    let(:definition_pegasus){ create :definition, glossary:pegasus }
    let(:sentence){ create :sentence }
    let(:lookup){ create :lookup, definition:definition_manticora, sentence:sentence }
    let(:lookup2){ create :lookup, definition:definition_pegasus, sentence:sentence }
    before do
      lookup; lookup2
      manticora.synonyms << pegasus 
    end
    subject{ find 'span.synonyms' }

    context "direct" do
      before{ visit glossary_path(manticora)}
      it{ should have_content 'pegasus' } 
      it{ should_not have_content 'manticora' } 
    end

    context "inverse" do
      before{ visit glossary_path(pegasus)}
      it{ should_not have_content 'pegasus' } 
      it{ should have_content 'manticora' } 
    end
  end
end
