# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Kanji edit" do
  before(:each) do
    signin_member
    kanji = FactoryGirl.create(:kanji, symbol:'魔')
    visit edit_kanji_path(kanji)
  end

  it "has a title" do
    page.should have_title('Edit 魔')
  end

  it "has a similars field" do
    value('Similars').should be_nil
  end
end
