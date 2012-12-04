require 'spec_helper'

describe SentencePresenter do
  describe '.glossaries' do
    let(:sentence){ mock_model Sentence }
    let(:presenter){ SentencePresenter.new(sentence,view)}

    context 'without glossaries' do
      before{ sentence.should_receive(:glossaries).once.and_return [] }
      it{ presenter.glossaries.should be_nil } 
    end

    context 'with glossaries' do
      let(:glossary){ mock_model Glossary }
      before do
        sentence.should_receive(:glossaries).twice.and_return [glossary]
        view.should_receive(:render).once.and_return nil
      end

      subject{ Capybara.string(presenter.glossaries)}
      it{ should have_selector 'ul.glossaries' }
    end
  end
end
