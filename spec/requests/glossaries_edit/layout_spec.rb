# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Glossary edit" do
  before(:each) do
    glossary = FactoryGirl.create(:glossary, content:'飲み込む', reading:'のみこむ')
    signin_member
    visit edit_glossary_path(glossary)
  end

  it "has a title" do
    page.should have_title('Edit Glossary')
  end

  it "has its content field filled in" do
    value('* Content').should eq '飲み込む' 
  end

  it "has its reading field filled in" do
    value('Reading').should eq 'のみこむ' 
  end

  it "has no sentence field" do
    value('Sentence').should be_nil
  end

  it "has an update button" do
    page.should have_button('Update Glossary')
  end
end
