# -*- coding: utf-8 -*-
require 'spec_helper'

describe KanjiPresenter do
  let(:kanji){ stub_model Kanji }
  let(:presenter){ KanjiPresenter.new(kanji,view)}

  describe '.random_glossary' do
    context "without glossaries" do
      before{ kanji.should_receive(:random_glossary).once.and_return nil}
      it{ presenter.random_glossary.should be_nil }
    end

    context "with glossaries" do
      let(:glossary){ stub_model Glossary }
      before{ kanji.should_receive(:random_glossary).once.and_return glossary }

      subject{ Capybara.string(presenter.random_glossary) }
      it{ should have_selector 'span.random.glossary' }
    end
  end
end

describe KanjiPresenter do
  let(:kanji){ mock_model Kanji }
  let(:presenter){ KanjiPresenter.new(kanji,view)}

  def setup_character
    kanji.should_receive(:character).once.and_return '鬼'
  end
  def setup_meanings
    @devil = mock_model(Meaning, name:'devil')
    @demon = mock_model(Meaning, name:'demon')
    kanji.should_receive(:meanings).once.and_return [@devil, @demon]
  end
  def setup_random_glossary
    kanji.should_receive(:random_glossary).once.and_return "glossary" 
    view.should_receive(:render).once.and_return '<span class="glossary">鬼婆(おにばば)</span>'.html_safe 
  end

  #describe '.present' do
  #  before do
  #    setup_character
  #    setup_meanings
  #  end

  #  subject{ Capybara.string(presenter.present)}
  #  it{ should have_selector 'span.character' }
  #  it{ should have_selector 'span.meanings' }
  #  its(:text){ should eq '鬼 - devil, demon' }
  #end

  #describe '.present_full' do
  #  before do
  #    setup_character
  #    setup_meanings
  #    setup_random_glossary
  #  end

  #  subject{ Capybara.string(presenter.present_full)}
  #  it{ should have_selector 'span.character' }
  #  it{ should have_selector 'span.meanings' }
  #  it{ should have_selector 'span.glossary' }
  #  its(:text){ should eq '鬼 - devil, demon - 鬼婆(おにばば)' }
  #end

  describe '.character' do
    before{ setup_character }
    let(:rendered){ Capybara.string(presenter.character)}
    subject{ rendered }
    its(:text){ should eq '鬼' }

    context "link" do
      subject{ rendered.find('a')}
      its(:text){ should eq '鬼' }
      specify{ subject[:href].should eq kanji_path(kanji)}
    end
  end

  describe '.meanings' do
    before{ setup_meanings }
    let(:rendered){ Capybara.string(presenter.meanings)}
    subject{ rendered }
    its(:text){ should eq 'devil, demon' }

    context "first link" do
      subject{ rendered.all('a')[0]}
      its(:text){ should eq 'devil' }
      specify{ subject[:href].should eq meaning_path(@devil)}
    end

    context "second link" do
      subject{ rendered.all('a')[1]}
      its(:text){ should eq 'demon' }
      specify{ subject[:href].should eq meaning_path(@demon)}
    end
  end

  describe '#similars' do
    context 'without similars' do
      context "section" do
        before{ kanji.should_receive(:similarities_total).and_return []}
        subject{ Capybara.string(presenter.similars)}
        its(:text){ should be_blank }
      end

      context "inline" do
        before{ kanji.should_receive(:similars_total).and_return []}
        subject{ Capybara.string(presenter.similars :span)}
        its(:text){ should be_blank }
      end
    end

    context 'with similars' do
      let(:similar){ stub_model Kanji }
      context "section" do
        before do
          controller.stub(:current_user){ create :user }
          kanji.should_receive(:similarities_total).and_return [similarity]
        end
        let(:similarity){ stub_model Similarity, secondary:similar }

        subject{ Capybara.string(presenter.similars)}
        it{ should have_selector 'h4', text:'Similars' }
        it{ should have_selector 'ul.similars.kanjis li.similar.kanji', count:1}
      end

      context "inline" do
        let(:similar){ stub_model Kanji }
        before{ kanji.should_receive(:similars_total).and_return [similar] }
        subject{ Capybara.string(presenter.similars :span)}
      
        it{ should_not have_selector 'h4', text:'Similars' }
        it{ should have_selector 'span.similars.kanjis span.similar.kanji', count:1}
      end
    end 
  end # #similars

  describe '#glossaries' do
    subject{ Capybara.string(presenter.glossaries)}

    context "without glossaries" do
      before{ kanji.should_receive(:glossaries).and_return []}
      its(:text){ should be_blank }
    end

    context "with glossaries" do
      let(:glossary){ stub_model Glossary }
      before{ kanji.should_receive(:glossaries).and_return [glossary] }
      it{ should have_selector 'h4', text:'Glossaries' }
      it{ should have_selector 'ul.glossaries li.glossary' } 
    end
  end # #glossaries
end
