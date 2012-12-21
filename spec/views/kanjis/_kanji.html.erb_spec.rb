require 'spec_helper'

describe 'kanjis/_kanji.html.erb' do
  let(:glossary){ stub_model Glossary }
  let(:kanji){ stub_model Kanji, glossaries:[glossary] }
  before{ render kanji, extra_class:'similar', taken_glossary:nil }

  subject{ Capybara.string(rendered) }
  it{ should have_selector 'span.character' }
  it{ should have_selector 'span.similars.kanjis' }
  it{ should have_selector 'span.meanings' }
  it{ should have_selector 'span.random.glossary' }
end
