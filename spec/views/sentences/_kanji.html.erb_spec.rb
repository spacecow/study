# -*- coding: utf-8 -*-
require 'spec_helper'

describe 'sentences/kanji.html.erb', focus:true do
  let(:kanji){ create(:kanji) }

  context "without similars" do
    before{ render 'sentences/kanji', kanji:kanji }
  
    subject{ Capybara.string(rendered)}
    it{ should have_content '魔' }
    it{ should_not have_content '魔 ()' }
  end

  context "with similars" do
    before do
      kanji.similars << create(:kanji, symbol:'鬼')
      render 'sentences/kanji', kanji:kanji
    end
  
    subject{ Capybara.string(rendered)}
    it{ should have_content '魔 (鬼)' }
  end
end
