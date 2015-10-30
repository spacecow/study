require 'capybara'

class ErbBinding
  def initialize hash
    hash.each_pair do |key, value|
      instance_variable_set('@' + key.to_s, value)
    end
  end
end

describe "sentences/show.html.erb" do

  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ "./app/views/sentences/show.html.erb" }
  let(:locals){{ sentence:sentence }}

  let(:sentence){ double :sentence }
  let(:presenter){ double :presenter }

  before do
    def bind.present mdl; end
    bind.should_receive(:present).with(sentence).and_yield presenter
    bind.should_receive(:title).with(:japanese){ "japanese" }
    bind.should_receive(:subtitle).with(:english){ "english" }
    presenter.should_receive(:glossaries){ "glossaries" }
    presenter.should_receive(:edit_link){ "edit glossary" }
    sentence.should_receive(:japanese){ :japanese }
    sentence.should_receive(:english){ :english }
  end

  subject(:div){ Capybara.string(rendering).find(".sentence") }

  context "glossary list" do
    subject{ div.find("ul.glossaries").text.strip }
    it{ should eq "glossaries" }
  end

  context "footer section" do
    subject{ div.find(".footer").text.strip }
    it{ should eq "edit glossary" }
  end

end

if false

require 'spec_helper'

describe 'sentences/show.html.erb' do
  let(:sentence){ stub_model(Sentence, english:'english sentence', japanese:'japanese sentence')}
  let(:definition){ create :definition }

  before do
    controller.stub(:current_user){ create :user }
    assign(:sentence, sentence)
    create :lookup, sentence:sentence, definition:definition
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

end
