# -*- coding: utf-8 -*-
require 'spec_helper'

describe SentencePresenter do
  let(:sentence){ mock_model Sentence }
  let(:presenter){ SentencePresenter.new(sentence,view)}

  describe '#english' do
    before{ sentence.should_receive(:english).and_return 'Japanese' }
    let(:rendered){ Capybara.string(presenter.english)}

    subject{ rendered }
    its(:text){ should eq 'Japanese' }

    context "link" do
      subject{ rendered.find('a') }
      its(:text){ should eq 'Japanese' }
      specify{ subject[:href].should eq sentence_path(sentence) }
    end
  end

  describe '#japanese' do
    before{ sentence.should_receive(:japanese).and_return '日本語' }
    let(:rendered){ Capybara.string(presenter.japanese)}

    subject{ rendered }
    its(:text){ should eq '日本語' }

    context "link" do
      subject{ rendered.find('a') }
      its(:text){ should eq '日本語' }
      specify{ subject[:href].should eq sentence_path(sentence) }
    end
  end

  describe '#glossaries' do
    context 'without glossaries' do
      before{ sentence.should_receive(:glossaries).once.and_return [] }
      it{ presenter.glossaries.should be_nil } 
    end

    context 'with glossaries' do
      let(:glossary){ stub_model Glossary }
      before do
        controller.stub(:current_user){ nil }
        sentence.should_receive(:glossaries).once.and_return [glossary]
      end

      subject{ Capybara.string(presenter.glossaries)}
      it{ should have_selector 'li.glossary', count:1 }
    end
  end

  describe '#sentences' do
    context 'without sentences' do
      it{ presenter.sentences([]).should be_nil }
    end

    context "with sentences" do
      let(:new_sentence){ stub_model Sentence }
      subject{ Capybara.string(presenter.sentences [new_sentence])}
      it{ should have_selector 'li.sentence', count:1 }
    end
  end
end
