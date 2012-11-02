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
      before{ kanji.glossaries << create(:glossary, content:'魔法')}
      subject{ Capybara.string(presenter.random_glossary)}
      it{ should have_selector('span.glossary.random', count:1)} 

      context 'one' do
        subject{ Capybara.string(presenter.random_glossary).find('span.glossary.random')}
        it{ should have_content '魔法' }
      end # one

      context 'two' do
        before{ kanji.glossaries << create(:glossary, content:'小悪魔')}
        subject{ Capybara.string(presenter.random_glossary).find('span.glossary.random')}
        it do
          if subject.text == ' - 魔法'
            should_not have_content '小悪魔'
            should have_content '魔法'
          else
            should_not have_content '魔法'
            should have_content '小悪魔'
          end
        end
      end # two 

      context 'two, where one is taken' do
        let(:glossary){ create(:glossary, content:'小悪魔')}
        before{ kanji.glossaries << glossary }
        subject{ Capybara.string(presenter.random_glossary(glossary)).find('span.glossary.random')}
        it{ should have_content '魔法' }
        it{ should_not have_content '小悪魔' }
      end # two, where one is taken
    end # with glossaries
  end # #random_glossary 
end
