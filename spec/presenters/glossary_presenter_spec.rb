# -*- coding: utf-8 -*-
require 'spec_helper'

describe GlossaryPresenter do
  describe '.content' do
    let(:glossary){ mock_model Glossary }
    let(:similar){ mock_model Glossary }
    let(:presenter){ GlossaryPresenter.new(glossary,view)}
    let(:rendered){ Capybara.string(presenter.content)}

    describe "content span" do
      before do
        @selector = 'span.content'
        glossary.should_receive(:content).once.and_return '故障'
        glossary.should_receive(:reading).once.and_return 'こしょう'
        glossary.should_receive(:similars_total).once.and_return [similar]
        similar.should_receive(:content).once.and_return '胡椒'
      end
      subject{ rendered.find(@selector) }
      its(:text){ should eq '故障(こしょう; 胡椒)' } 

      describe "glossary link" do
        before{ @selector += " a" }
        subject{ rendered.all(@selector)[0]}
        its(:text){ should eq '故障' } 
        specify{ subject[:href].should eq glossary_path(glossary) }
      end

      describe "similar link" do
        before{ @selector += " a" }
        subject{ rendered.all(@selector)[1]}
        its(:text){ should eq '胡椒' } 
        specify{ subject[:href].should eq glossary_path(similar) }
      end
    end
  end

  describe '.form' do
    let(:glossary){ create :glossary, content:'飲み込む', reading:'のみこむ' }
    let(:presenter){ GlossaryPresenter.new(glossary,view)}

    let(:rendered){ Capybara.string(presenter.form)}
    describe 'form section' do
      before{ @selector = "div.form" }
      describe 'form' do
        before{ @selector += " form"}
        subject{ rendered.find(@selector)}

        describe "Content" do
          subject{ rendered.find_field 'Content' }
          its(:value){ should eq '飲み込む' }
        end

        describe "Reading" do
          subject{ rendered.find_field 'Reading' }
          its(:value){ should eq 'のみこむ' }
        end

        describe "Sentence" do
          subject{ rendered.find_field 'Sentence' }
          its(:value){ should be_nil } 
        end

        describe "Similars" do
          subject{ rendered.find_field 'Similars' }
          its(:value){ should be_nil } 
        end

        it{ should have_button 'Update Glossary' }
      end
    end
  end
end

describe GlossaryPresenter do
  let(:glossary){ create(:glossary) }
  let(:presenter){ GlossaryPresenter.new(glossary, view) }

  describe '#kanjis' do
    context 'without kanjis' do
      it{ presenter.kanjis.should be_nil }
    end # without kanjis

    context 'with kanjis' do
      before{ glossary.kanjis << create(:kanji, symbol:'鬼')}
      subject{ Capybara.string(presenter.kanjis)}
      it{ should have_selector 'ul.kanjis', count:1 }

      describe 'ul.kanjis' do
        subject{ Capybara.string(presenter.kanjis).find('ul.kanjis')}
        it{ should have_selector('li.kanji')}

        describe 'li.kanji' do
          subject{ Capybara.string(presenter.kanjis).find('ul.kanjis li.kanji')}
          it{ should have_content '鬼' }
        end
      end # ul.kanjis
    end # with kanjis
  end # #kanjis
end
