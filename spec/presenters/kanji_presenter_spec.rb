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

  describe '#similars' do
    context 'without similars' do
      it{ presenter.similars.should be_nil }
    end

    context 'with similars' do
      let(:similar){ create(:kanji, symbol:'鬼')}
      before{ kanji.similars << similar }
      subject{ Capybara.string(presenter.similars)}
      it{ should have_selector('span.similars', count:1)}

      describe 'span.similars' do
        subject{ Capybara.string(presenter.similars).find('span.similars')}
        it{ should have_selector('span.similar.kanji', count:1)}

        describe 'span.similar.kanji' do
          subject{ Capybara.string(presenter.similars).find('span.similars span.similar.kanji')}
          it{ should have_xpath "//a[@href='#{kanji_path(similar)}']", text:'鬼' }
        end
      end
    end # with similars
  end
end
