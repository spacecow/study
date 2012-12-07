require 'spec_helper'

describe 'kanjis/kanji.html.erb' do
  let(:kanji){ mock_model Kanji }
  before do
    kanji.stub(:character){ nil }
    kanji.stub(:meanings){ [] }
    render 'kanjis/kanji', kanji:kanji, klass:'similar'
  end

  subject{ Capybara.string(rendered) }
  it{ should have_selector 'li.kanji.similar' }
end
