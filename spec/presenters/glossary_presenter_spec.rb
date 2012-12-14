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

  describe ".present" do
    before do
      setup_content
      setup_reading
      setup_synonyms
      setup_similars
      setup_antonyms
    end

    subject{ Capybara.string(presenter.present :span)}
    it{ should have_selector 'span.content' }
    it{ should have_selector 'span.reading' }
    it{ should have_selector 'span.glossaries.synonyms' }
    it{ should have_selector 'span.glossaries.similars' }
    it{ should have_selector 'span.glossaries.antonyms' }
    its(:text){ should eq '魔法(まほう; 魔法使い; 胡椒 砂糖; 馬鹿)' }
  end

  describe ".content" do
    before{ setup_content }
    let(:rendered){ Capybara.string(presenter.content :span)}
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
      it{ presenter.reading(:span).should be_blank }
    end

    context "with reading" do
      before{ setup_reading }
      let(:rendered){ Capybara.string(presenter.reading :span)}
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
  # ----------------------------

  describe ".sentences" do
    context "without sentence" do
      before{ glossary.should_receive(:sentences).and_return [] }
      it{ presenter.sentences.should be_nil }
    end

    context "with sentences" do
      before do
        glossary.should_receive(:sentences).twice.and_return ['sentence']
        view.should_receive(:render).once.and_return nil
      end

      subject{ Capybara.string(presenter.sentences)} 
      it{ should have_selector 'ul.sentences' }
    end
  end

  describe ".synonyms" do
    context "without synonyms" do
      before{ glossary.should_receive(:synonym_glossaries_total?).once.and_return false }
      it{ presenter.synonyms.should be_nil }
    end

    context "with synonyms" do
      let(:synonym){ mock_model Glossary, content:'化け物屋敷' }
      let(:rendered){ Capybara.string(presenter.synonyms)}
      before do
        glossary.should_receive(:synonym_glossaries_total).once.and_return [[]]
        glossary.should_receive(:synonym_glossaries_total?).once.and_return true 
        view.should_receive(:render).once.and_return nil 
      end

      context "synonyms section" do
        before{ @selector = 'div.synonyms.glossaries' }
        subject{ rendered.find(@selector)}

        context "header" do
          before{ @selector += ' h4' }
          subject{ rendered.find(@selector)}
          its(:text){ should eq 'Synonyms' }
        end

        it{ should have_selector 'ul.synonyms.glossaries' }
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
      it{ presenter.kanjis.should be_nil }
      it{ presenter.kanjis(:ul).should be_nil }
    end # without kanjis

    context 'with kanjis' do
      before do
        glossary.should_receive(:kanjis).twice.and_return [glossary]
        view.should_receive(:render).once.and_return nil
      end

      subject{ Capybara.string(presenter.kanjis) }
      it{ should have_selector 'h4', text:'Kanjis' }
      it{ should have_selector 'ul.kanjis' }
    end # with kanjis
  end # #kanjis
end
