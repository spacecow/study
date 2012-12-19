require 'spec_helper'

describe 'Glossary show' do
  let(:manticora){ create :glossary, content:'manticora' }

  context "synonyms" do
    let(:pegasus){ create :glossary, content:'pegasus'}
    before{ manticora.synonyms << pegasus } 
    subject{ find 'div.synonyms' }

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
