# -*- coding: utf-8 -*-
require 'spec_helper'

describe GlossaryPresenter do
  let(:glossary){ mock_model Glossary }
  let(:presenter){ GlossaryPresenter.new(glossary,view)}

  describe ".synonyms" do
    context "without synonyms" do
      before{ glossary.should_receive(:synonyms_total).once.and_return [] }
      it{ presenter.synonyms.should be_nil }
    end

    context "with synonyms" do
      let(:synonym){ mock_model Glossary, content:'化け物屋敷' }
      let(:rendered){ Capybara.string(presenter.synonyms)}
      before do
        glossary.should_receive(:synonyms_total).twice.and_return [synonym]
        view.should_receive(:render).once.and_return nil 
      end

      context "synonyms section" do
        before{ @selector = 'div.synonyms.glossaries' }
        subject{ rendered.find(@selector)}

        context "header" do
          before{ @selector += ' h2' }
          subject{ rendered.find(@selector)}
          its(:text){ should eq 'Synonyms' }
        end

        it{ should have_selector 'ul.synonyms.glossaries' }
      end 
    end
  end

  describe ".similar_links" do
    context 'without similars' do
      before{ glossary.should_receive(:similars_total).once.and_return [] }
      it{ presenter.similar_links.should be_nil }
    end
    
    context 'with similars' do
      let(:rendered){ Capybara.string(presenter.similar_links)}
      let(:peppar){ mock_model Glossary, content:'胡椒' }
      let(:sugar){ mock_model Glossary, content:'砂糖' }
      before{ glossary.should_receive(:similars_total).twice.and_return [peppar,sugar]}

      context "similars section" do
        before{ @selector = 'span.similars' }
        subject{ rendered.find(@selector) }
        its(:text){ should eq '; 胡椒 砂糖' }
        specify{ subject[:class].should eq 'similars glossaries' }

        context "first link" do
          before{ @selector += " a" }
          subject{ rendered.all(@selector)[0] }
          its(:text){ should eq '胡椒' }
        end

        context "first link" do
          before{ @selector += " a" }
          subject{ rendered.all(@selector)[1] }
          its(:text){ should eq '砂糖' }
        end
      end
    end
  end

  describe '.content' do
    let(:synonym){ mock_model Glossary }
    let(:similar){ mock_model Glossary }
    let(:antonym){ mock_model Glossary }
    let(:rendered){ Capybara.string(presenter.content)}

    describe "content span" do
      before do
        @selector = 'span.content'
        glossary.should_receive(:content).once.and_return '故障'
        glossary.should_receive(:reading).once.and_return 'こしょう'
        glossary.should_receive(:synonyms_total).twice.and_return [synonym]
        glossary.should_receive(:similars_total).twice.and_return [similar]
        glossary.should_receive(:antonyms_total).twice.and_return [antonym]
        similar.should_receive(:content).once.and_return '胡椒'
        synonym.should_receive(:content).once.and_return 'ペッパー'
        antonym.should_receive(:content).once.and_return '水'
      end
      subject{ rendered.find(@selector) }
      its(:text){ should eq '故障(こしょう; ペッパー; 胡椒; 水)' } 

      describe "glossary link" do
        before{ @selector += " a" }
        subject{ rendered.all(@selector)[0]}
        its(:text){ should eq '故障' } 
        specify{ subject[:href].should eq glossary_path(glossary)}
      end

      describe "synonym link" do
        before{ @selector += " a" }
        subject{ rendered.all(@selector)[1]}
        its(:text){ should eq 'ペッパー' } 
        specify{ subject[:href].should eq glossary_path(synonym)}
      end

      describe "similar link" do
        before{ @selector += " a" }
        subject{ rendered.all(@selector)[2]}
        its(:text){ should eq '胡椒' } 
        specify{ subject[:href].should eq glossary_path(similar)}
      end

      describe "antonym link" do
        before{ @selector += " a" }
        subject{ rendered.all(@selector)[3]}
        its(:text){ should eq '水' } 
        specify{ subject[:href].should eq glossary_path(antonym)}
      end
    end
  end # .content
end


describe GlossaryPresenter do
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

        describe "Synonyms" do
          subject{ rendered.find_field 'Synonyms' }
          its(:value){ should be_nil } 
        end

        describe "Similars" do
          subject{ rendered.find_field 'Similars' }
          its(:value){ should be_nil } 
        end

        describe "Antonym" do
          subject{ rendered.find_field 'Antonyms' }
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
