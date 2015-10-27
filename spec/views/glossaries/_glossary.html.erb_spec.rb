# -*- coding: utf-8 -*-
require 'spec_helper'

describe "glossaries/glossary.html.erb" do
  let(:sentence){ create :sentence }
  let(:glossary){ create :glossary, reading:'あほう', sentences:[sentence] }
  let(:lookup){ create :lookup, meaning:'meaning', glossary:glossary, sentence:sentence }
  before do
    controller.stub(:current_user){ nil }
    render glossary, sentences:true, kanjis:true, extra_class:'', glossary_tag:'li', lookup:lookup
  end

  subject{ Capybara.string(rendered) }
  it{ should have_selector 'span.content' }
  it{ should have_selector 'span.parenthesis' }
  it{ should have_selector 'span.actions' }
  it{ should have_selector 'ul.sentences' }
end
