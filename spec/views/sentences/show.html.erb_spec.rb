require 'spec_helper'

describe 'sentences/show.html.erb' do
  before do
    controller.stub(:current_user){ create :user }
    assign(:sentence, mock_model(Sentence, english:'english sentence', japanese:'japanese sentence').as_null_object)
    render
  end

  subject{ Capybara.string(rendered)}
  it do p subject.text end
  it{ should have_selector 'h1', text:'japanese sentence' }
  it{ should have_selector 'h3', text:'english sentence' }
  it{ should have_selector 'div.glossaries' }
  it{ should have_selector 'div#footer', text:'Edit' }
end
