require 'spec_helper'

describe "sentences/sentence.html.erb" do
  let(:definition){ create :definition }
  let(:sentence){ stub_model Sentence, definitions:[definition] }

  context "base layout" do
    before{ render sentence, glossaries:false }

    subject{ Capybara.string(rendered) }
    it{ should have_selector 'div.japanese' }
    it{ should have_selector 'div.english' }
  end

  context "without glossaries" do
    before{ render sentence, glossaries:false }

    subject{ Capybara.string(rendered) }
    it{ should_not have_selector 'ul.glossaries' }
  end

  context "with glossaries" do
    before do
      controller.stub(:current_user){ nil }
      render sentence, glossaries:true
    end

    subject{ Capybara.string(rendered) }
    it{ should have_selector 'ul.glossaries' }
  end
end
