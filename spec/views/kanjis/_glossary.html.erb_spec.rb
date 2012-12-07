require 'spec_helper'

describe 'kanjis/glossary.html.erb' do
  let(:glossary){ mock_model Glossary }
  before do
    glossary.stub(:synonyms_total){ [] }
    glossary.stub(:similars_total){ [] }
    glossary.stub(:antonyms_total){ [] }
    render 'kanjis/glossary', glossary:glossary
  end

  subject{ Capybara.string(rendered) }
  it{ should have_selector 'li.glossary' }
end
