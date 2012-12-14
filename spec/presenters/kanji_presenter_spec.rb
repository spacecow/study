# -*- coding: utf-8 -*-
require 'spec_helper'

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

  describe '.present' do
    before do
      setup_character
      setup_meanings
    end

    subject{ Capybara.string(presenter.present)}
    it{ should have_selector 'span.character' }
    it{ should have_selector 'span.meanings' }
    its(:text){ should eq '鬼 - devil, demon' }
  end

  describe '.present_full' do
    before do
      setup_character
      setup_meanings
      setup_random_glossary
    end

    subject{ Capybara.string(presenter.present_full)}
    it{ should have_selector 'span.character' }
    it{ should have_selector 'span.meanings' }
    it{ should have_selector 'span.glossary' }
    its(:text){ should eq '鬼 - devil, demon - 鬼婆(おにばば)' }
  end

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

  describe '.random_glossary' do
    context "without glossaries" do
      before{ kanji.should_receive(:random_glossary).once.and_return nil}
      it{ presenter.random_glossary.should be_nil }
    end

    context "with glossaries" do
      before do
        kanji.should_receive(:random_glossary).once.and_return "glossary"
        view.should_receive(:render).once.and_return nil
      end

      it{ presenter.random_glossary.should be_nil }
    end
  end

  describe '.similars' do
    context 'without similars' do
      before{ kanji.should_receive(:similars).once.and_return []}
      it{ presenter.similars.should be_nil }
    end

    context 'with similars' do
      before do
        kanji.should_receive(:similars).twice.and_return ['whatever']
        view.should_receive(:render).once.and_return nil
      end

      subject{ Capybara.string(presenter.similars)}
      it{ should have_selector 'h4' }
      it{ should have_selector 'ul.similars'}

      #describe 'span.similars' do
      #  subject{ Capybara.string(presenter.similars).find('span.similars')}
      #  it{ should have_selector('span.similar.kanji', count:1)}

      #  describe 'span.similar.kanji' do
      #    subject{ Capybara.string(presenter.similars).find('span.similars span.similar.kanji')}
      #    it{ should have_xpath "//a[@href='#{kanji_path(similar)}']", text:'鬼' }
      #  end
      #end
    end # with similars
  end
end
