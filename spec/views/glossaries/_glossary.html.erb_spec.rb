# -*- coding: utf-8 -*-
require 'spec_helper'

describe "glossaries/glossary.html.erb" do
  let(:sentence){ stub_model Sentence }
  let(:glossary){ stub_model Glossary, reading:'あほう', sentences:[sentence] }
  before{ render glossary, sentences:true, kanjis:true, extra_class:'', glossary_tag:'li' }

  subject{ Capybara.string(rendered) }
  it{ should have_selector 'span.content' }
  it{ should have_selector 'span.parenthesis' }
  it{ should have_selector 'ul.sentences' }
end
