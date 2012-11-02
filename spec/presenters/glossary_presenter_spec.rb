# -*- coding: utf-8 -*-
require 'spec_helper'

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
