# -*- coding: utf-8 -*-
require 'spec_helper'

describe "glossaries/glossary.html.erb" do
  let(:glossary){ create :glossary }
  let(:definition){ create :definition } 
  let(:lookup){ create :lookup, definition:definition }
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
