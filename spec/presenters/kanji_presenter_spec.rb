# -*- coding: utf-8 -*-
require 'spec_helper'

describe KanjiPresenter do
  let(:kanji){ create(:kanji) }
  let(:presenter){ KanjiPresenter.new(kanji, view) }

  describe '#random_glossary' do
    context 'without glossaries' do
      it{ presenter.random_glossary.should be_nil }
    end # without glossaries 

    context 'with glossary' do
      let(:glossary){ create(:glossary, content:'魔法', reading:'まほう')}
      before{ kanji.glossaries << glossary }
      subject{ Capybara.string(presenter.random_glossary)}
      it{ should have_selector('span.glossary.random', count:1)} 

      context 'one' do
        subject{ Capybara.string(presenter.random_glossary).find('span.glossary.random')}
        it{ should have_xpath "//a[@href='#{glossary_path(glossary)}']", text:'魔法(まほう)'}
      end # one

      context 'one that is taken' do
        it{ presenter.random_glossary(glossary).should be_nil }
      end # one that is taken

      context 'two' do
        before{ kanji.glossaries << create(:glossary, content:'小悪魔')}
        subject{ Capybara.string(presenter.random_glossary).find('span.glossary.random')}
        it do
          if subject.text =~ /魔法/
            should_not have_content '小悪魔'
            should have_content '魔法'
          else
            should_not have_content '魔法'
            should have_content '小悪魔'
          end
        end
      end # two 

      context 'two, where one is taken' do
        before{ kanji.glossaries << create(:glossary, content:'小悪魔')}
        subject{ Capybara.string(presenter.random_glossary(glossary)).find('span.glossary.random')}
        it{ should have_content '小悪魔' }
        it{ should_not have_content '魔法' }
      end # two, where one is taken
    end # with glossaries
  end # #random_glossary 
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

  describe '.present' do
    before{ setup_character; setup_meanings }
    subject{ Capybara.string(presenter.present)}
    it{ should have_selector 'span.character' }
    it{ should have_selector 'span.meanings' }
    its(:text){ should eq '鬼 - devil, demon' }
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
