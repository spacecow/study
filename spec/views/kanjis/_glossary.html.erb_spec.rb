require 'spec_helper'

describe 'kanjis/glossary.html.erb' do
  let(:glossary){ mock_model Glossary }
  before do
    glossary.should_receive(:synonyms_total).once.and_return []
    glossary.should_receive(:similars_total).once.and_return []
    glossary.should_receive(:antonyms_total).once.and_return []
    render 'kanjis/glossary', glossary:glossary, extra_class:'random'
  end

  subject{ Capybara.string(rendered) }
  it{ should have_selector '.glossary' }
end
