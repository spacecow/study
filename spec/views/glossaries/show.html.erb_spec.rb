# -*- coding: utf-8 -*-
require 'spec_helper'

describe 'glossaries/show.html.erb' do
  let(:glossary){ stub_model Glossary, content:'胡椒' }
  before do
    controller.stub(:current_user){ create :user }
    assign(:glossary, glossary)
    render
  end

  subject{ Capybara.string(rendered)}
  it{ should have_selector 'h1', text:'胡椒' }
  it{ should_not have_selector 'div.content' }
  it{ should have_selector 'ul.sentences' }
  it{ should have_selector 'div.kanjis' }
  it{ should have_selector 'div.glossaries.synonyms' }
  it{ should have_selector 'div.glossaries.similars' }
  it{ should have_selector 'div.glossaries.antonyms' }
  it{ should have_selector 'div.footer', text:'Edit' }

  describe "footer section" do
    subject{ Capybara.string(rendered).find('div.footer')}
    it{ should have_content 'Edit' }
  end
end
