require 'spec_helper'

describe 'sentences/show.html.erb' do
  let(:sentence){ stub_model(Sentence, english:'english sentence', japanese:'japanese sentence')}
  let(:glossary){ create :glossary }

  before do
    controller.stub(:current_user){ create :user }
    assign(:sentence, sentence)
    create :lookup, sentence:sentence, glossary:glossary
    render
  end

  subject{ Capybara.string(rendered)}
  it{ should have_selector 'h1', text:'japanese sentence' }
  it{ should have_selector 'h3', text:'english sentence' }
  it{ should_not have_selector 'div.japanese' }
  it{ should_not have_selector 'div.english' }
  it{ should have_selector 'ul.glossaries' }
  it{ should have_selector 'div.footer', text:'Edit' }
end
