# -*- coding: utf-8 -*-
require 'spec_helper'

describe 'sentences/kanji.html.erb' do
  let(:kanji){ create(:kanji, symbol:'魔') }

  context "without glossaries" do
    context "without similars" do
      before{ render 'sentences/kanji', kanji:kanji, taken_glossary:nil }
    
      subject{ Capybara.string(rendered)}
      it{ should have_content '魔' }
      it{ should_not have_content '魔 ()' }
    end

    context "with similars" do
      before do
        kanji.similars << create(:kanji, symbol:'鬼')
        render 'sentences/kanji', kanji:kanji, taken_glossary:nil
      end
    
      subject{ Capybara.string(rendered)}
      it{ should have_content '魔 (鬼)' }
    end
  end #without sentences

  context "with glossaries" do
    before{ kanji.glossaries << create(:glossary, content:'魔法', reading:'まほう')}
    context "with similars" do
      before do
        kanji.similars << create(:kanji, symbol:'鬼')
        render 'sentences/kanji', kanji:kanji, taken_glossary:nil
      end
      subject{ Capybara.string(rendered)}
      it{ should have_content '魔 (鬼) - 魔法(まほう)' }
    end

    context "without similars" do
      before{ render 'sentences/kanji', kanji:kanji, taken_glossary:nil }
      subject{ Capybara.string(rendered)}
      it{ should have_content '魔 - 魔法' }
      it{ should_not have_content '魔 () - 魔法' }
    end
  end #with glossaries
end
