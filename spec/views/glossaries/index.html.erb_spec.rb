require 'spec_helper'

describe "glossaries/index.html.erb" do
  before  do
    controller.stub(:current_user){ create :user }
    glossary = create :glossary
    sentence = create :sentence
    lookup = create :lookup, glossary:glossary, sentence:sentence
    assign(:glossaries,[glossary])
    assign(:lookups,[lookup])
    render
  end

  subject{ Capybara.string(rendered) }
  it{ should have_selector 'h1', text:'Glossaries' }
  it{ should have_selector 'ul.glossaries' }
  it{ should have_link 'New Glossary' }
end
