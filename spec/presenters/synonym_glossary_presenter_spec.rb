# -*- coding: utf-8 -*-
require 'spec_helper'

describe SynonymGlossaryPresenter do
  let(:glossary){ mock_model Glossary }
  let(:relative){ mock_model SynonymGlossary }
  let(:presenter){ SynonymGlossaryPresenter.new(relative,glossary,view)}

  describe '.kanjis' do
    context "without kanjis" do
      before{ relative.should_receive(:secondary_kanjis).once.with(glossary).and_return []}
      it{ presenter.kanjis.should be_nil }  
    end # without kanjis

    context "with kanjis" do
      let(:kanji){ mock_model Kanji }
      before do
        relative.should_receive(:secondary_kanjis).twice.with(glossary).and_return [kanji]
        relative.should_receive(:secondary).once.with(glossary).and_return nil
        view.should_receive(:render).once
      end

      subject{ Capybara.string(presenter.kanjis)}
      it{ should have_selector 'ul.kanjis' } 
    end # with kanjis
  end

  describe '.actions' do
    let(:user){ create :user }
    let(:rendered){ Capybara.string(presenter.actions)}
    before do
      @selector = "span.actions"
      controller.stub(:current_user){ user }
    end

    context "delete link" do
      before{ @selector += ' a' }
      subject{ rendered.find(@selector) }
      its(:text){ should eq 'Delete' }
      specify{ subject[:href].should eq synonym_glossary_path(relative,main:glossary) }
      specify{ subject['data-method'].should eq 'delete' }
    end
  end # .actions

  describe ".reading" do
    context "without reading" do
      before{ relative.should_receive(:secondary_reading).once.with(glossary).and_return '' }
      it{ presenter.reading.should be_nil }
    end

    context "with reading" do
      let(:rendered){ Capybara.string(presenter.reading)}
      before{ relative.should_receive(:secondary_reading).twice.with(glossary).and_return 'こしょう' }

      context "reading section" do
        before{ @selector = "span.reading" }
        subject{ rendered.find(@selector)}
        its(:text){ should eq 'こしょう' }
      end
    end
  end

  #describe ".content", focus:true do
  #  let(:secondary){ mock_model Glossary }
  #  before do
  #    relative.should_receive(:secondary_content).once.with(glossary).and_return '胡椒'
  #    relative.should_receive(:secondary).once.with(glossary).and_return secondary 
  #  end
  #  let(:rendered){ Capybara.string(presenter.content)}

  #  context "content section" do
  #    before{ @selector = "span.content" }
  #    subject{ rendered.find(@selector)}
  #    its(:text){ should eq '胡椒' }

  #    context "secondary link" do
  #      before{ @selector += " a" }
  #      subject{ rendered.find(@selector)}
  #      its(:text){ should eq '胡椒' }
  #      specify{ subject[:href].should eq glossary_path(secondary)}
  #    end
  #  end
  #end
end
