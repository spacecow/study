require 'spec_helper'

describe SentencePresenter do
  let(:sentence){ create(:sentence) }
  let(:presenter){ SentencePresenter.new(sentence, view) }
  
  describe '#glossaries' do
    context 'without glossaries' do
      it{ presenter.glossaries.should be_nil }
    end # without glossaries

    context 'with glossaries' do
      before{ sentence.glossaries << create(:glossary)}
      subject{ Capybara.string(presenter.glossaries)}
      it{ should have_selector('ul.glossaries', count:1)} 

      describe 'ul.glossaries' do
        subject{ Capybara.string(presenter.glossaries).find('ul.glossaries')}
        it{ should have_selector('li.glossary')}
      end
    end # with glossaries
  end
end
