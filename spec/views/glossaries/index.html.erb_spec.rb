require 'spec_helper'

describe "glossaries/index.html.erb", focus:true do
  before  do
    render
  end

  subject{ Capybara.string(rendered) }
  it{ should have_selector 'h1', text:'Glossaries' }
end
