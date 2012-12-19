# -*- coding: utf-8 -*-
require 'spec_helper'

describe GlossaryPresenter do
  let(:glossary){ mock_model Glossary }
  let(:presenter){ GlossaryPresenter.new(glossary,view)}

  # PRESENT -------------------

  def setup_content
    glossary.should_receive(:content).once.and_return '魔法'
  end
  def setup_reading
    glossary.should_receive(:reading).once.and_return 'まほう'
  end
  def setup_synonyms
    synonym = mock_model Glossary, content:'魔法使い'
    glossary.should_receive(:synonyms_total).once.and_return [synonym]
  end
  def setup_similars
    peppar =  mock_model Glossary, content:'胡椒'
    sugar = mock_model Glossary, content:'砂糖'
    glossary.should_receive(:similars_total).once.and_return [peppar,sugar]
  end
  def setup_antonyms
    antonym = mock_model Glossary, content:'馬鹿'
    glossary.should_receive(:antonyms_total).once.and_return [antonym]
  end

  describe ".parenthesis" do
    context "without content" do
      before do
        glossary.should_receive(:reading).once.and_return nil
        glossary.should_receive(:synonyms_total).once.and_return nil
        glossary.should_receive(:similars_total).once.and_return nil
        glossary.should_receive(:antonyms_total).once.and_return nil
      end

      specify{ presenter.parenthesis.should be_nil }
    end

    context "with content" do
      before do
        setup_reading
        setup_synonyms
        setup_similars
        setup_antonyms
      end

      subject{ Capybara.string(presenter.parenthesis)}
      it{ should have_selector 'span.reading' }
      it{ should have_selector 'span.glossaries.synonyms' }
      it{ should have_selector 'span.glossaries.similars' }
      it{ should have_selector 'span.glossaries.antonyms' }
      its(:text){ should eq '(まほう; 魔法使い; 胡椒 砂糖; 馬鹿)' }
    end # with content
  end # .parenthesis

  describe ".content" do
    before{ setup_content }
    let(:rendered){ Capybara.string(presenter.content)}
    subject{ rendered }
    its(:text){ should eq '魔法' }

    context "link" do
      subject{ rendered.find 'a' }
      its(:text){ should eq '魔法' }
      specify{ subject[:href].should eq glossary_path(glossary) }
    end
  end

  describe ".reading" do
    context "without reading" do
      before{ glossary.should_receive(:reading).once.and_return nil }  
      it{ presenter.reading.should be_blank }
    end

    context "with reading" do
      before{ setup_reading }
      let(:rendered){ Capybara.string(presenter.reading)}
      subject{ rendered }
      its(:text){ should eq 'まほう' }
    end
  end

  describe ".similar_links" do
    context 'without similars' do
      before{ glossary.should_receive(:similars_total).once.and_return [] }
      it{ presenter.similar_links.should be_blank }
    end
    
    context 'with similars' do
      before{ setup_similars }
      let(:rendered){ Capybara.string(presenter.similar_links)}

      context "similars section" do
        before{ @selector = 'span.similars' }
        subject{ rendered.find(@selector) }
        its(:text){ should eq '胡椒 砂糖' }
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
  # ----------------------------

  describe "#glossaries" do
    context "without glossaries" do
      it{ presenter.glossaries([]).should be_nil }
    end

    context "with glossaries" do
      let(:glossaries){ [stub_model(Glossary)] }
      subject{ Capybara.string(presenter.glossaries(glossaries))}
      it{ should have_selector 'li.glossary', count:1 }  
    end
  end

  describe ".sentences" do
    context "without sentence" do
      before{ glossary.should_receive(:sentences).and_return [] }
      subject{ Capybara.string(presenter.sentences)}
      its(:text){ should be_blank }
    end

    context "with sentences" do
      let(:sentence){ stub_model Sentence }
      before do
        glossary.should_receive(:sentences).once.and_return [sentence] 
      end

      subject{ Capybara.string(presenter.sentences)} 
      it{ should have_selector 'li.sentence', count:1 }
    end
  end

  describe ".synonyms" do
    context "without synonyms" do
      before{ glossary.should_receive(:synonym_glossaries_total).and_return [] }
      subject{ Capybara.string(presenter.synonyms)}
      its(:text){ should be_blank }
    end

    context "with synonyms" do
      let(:synonym){ stub_model Glossary }
      let(:synonym_glossary){ stub_model SynonymGlossary, secondary:synonym }
      let(:rendered){ Capybara.string(presenter.synonyms)}
      before do
        controller.stub(:current_user){ create :user }
        glossary.should_receive(:synonym_glossaries_total).and_return [synonym_glossary]
      end

      context "header" do
        subject{ rendered.find('h4')}
        its(:text){ should eq 'Synonyms' }
      end

      context "list" do
        subject{ rendered.find('ul.synonyms.glossaries')}
        it{ should have_selector 'li.glossary.synonym', count:1 }
      end
    end 
  end
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
  let(:glossary){ mock_model Glossary }
  let(:presenter){ GlossaryPresenter.new(glossary, view) }

  describe '#kanjis' do
    context 'without kanjis' do
      before{ glossary.should_receive(:kanjis).once.and_return []}
      context 'section' do
        subject{ Capybara.string(presenter.kanjis)}
        its(:text){ should be_empty }
      end

      context 'list' do
        subject{ Capybara.string(presenter.kanjis(nil,:ul))}
        its(:text){ should be_empty }
      end
    end # without kanjis

    context 'with kanjis' do
      let(:kanji){ stub_model Kanji }
      before{ glossary.should_receive(:kanjis).once.and_return [kanji] }

      context "section" do
        subject{ Capybara.string(presenter.kanjis) }
        it{ should have_selector 'h4', text:'Kanjis' }
        it{ should have_selector 'ul.kanjis li.kanji', count:1 }
      end

      context "section" do
        subject{ Capybara.string(presenter.kanjis(nil,:ul)) }
        it{ should have_selector 'li.kanji', count:1 }
      end
    end # with kanjis
  end # #kanjis
end
