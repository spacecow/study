# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Kanji update" do
  before(:each) do
    signin_member
    @magic = FactoryGirl.create(:kanji, symbol:'魔')
    visit edit_kanji_path(@magic)
  end

  context "link to already existing kanjis" do
    before(:each) do
      @trees = FactoryGirl.create(:kanji, symbol:'林')
      @demon = FactoryGirl.create(:kanji, symbol:'鬼')
      fill_in 'Similars', with:"#{@trees.id}, #{@demon.id}"
      @similarities_no = Similarity.count
      click_button 'Update Kanji'
    end

    it "saves similarities to db" do
      Similarity.count.should be(@similarities_no+4)
    end

    it "bothway references" do
      @magic.similars.should eq [@trees, @demon]
      @trees.similars.should eq [@magic]
      @demon.similars.should eq [@magic]
    visit edit_kanji_path(@magic)
    end
  end

  #context "link to non existing kanjis" do
  #  before(:each) do
  #    fill_in 'Similars', with:"<<<林>>>, <<<鬼>>>"
  #    @similarities_no = Similarity.count
  #    @kanji_no = Kanji.count
  #    click_button 'Update Kanji'
  #  end

  #  it "saves similarities to db" do
  #    Similarity.count.should be(@similarities_no+2)
  #  end

  #  it "saves new kanjis to db" do
  #    Kanji.count.should be(@kanji_no+2)
  #  end
  #end
end

