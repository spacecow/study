# -*- coding: utf-8 -*-

require 'spec_helper'

describe 'kanjis/show.html.erb' do
  let(:kanji){ stub_model(Kanji, symbol:'魔')}
  before do
    controller.stub(:current_user){ create :user }
    assign(:kanji, kanji)
    render 
  end

  describe "base layout" do
    subject{ Capybara.string(rendered)}
    it{ should have_selector 'h1', text:'魔' } 
    it{ should have_selector 'div.meanings' }
    it{ should have_selector 'div.glossaries' }
    it{ should have_selector 'div.similars.kanjis' }
    it{ should have_selector 'div.footer', text:'Edit' }
  end
end
