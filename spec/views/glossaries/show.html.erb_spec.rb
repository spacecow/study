# -*- coding: utf-8 -*-
require 'spec_helper'

describe 'glossaries/show.html.erb' do
  let(:sentence){ mock_model Sentence }
  before do
    assign(:glossary, mock_model(Glossary, content:'胡椒').as_null_object)
    controller.stub(:current_user){ create :user }
    render
  end

  describe "base layout" do
    subject{ Capybara.string(rendered) }
    it{ should have_selector 'h1', text:'胡椒' }

    describe "glossary section" do
      before{ @selector = 'div.glossary' }
      subject{ Capybara.string(rendered).find(@selector)}
      it{ should_not have_selector 'div.content' }
      it{ should have_selector 'ul.sentences' }
      it{ should have_selector 'div.glossaries.synonyms' }
      it{ should have_selector 'div.glossaries.similars' }
      it{ should have_selector 'div.glossaries.antonyms' }

      describe "footer section" do
        before{ @selector += ' div.footer' }
        subject{ Capybara.string(rendered).find(@selector)}
        it{ should have_content 'Edit' }
      end
    end
  end
end
