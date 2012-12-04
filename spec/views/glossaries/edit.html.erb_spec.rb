require 'spec_helper'

describe 'glossaries/edit.html.erb' do
  before do
    assign(:glossary, stub_model(Glossary))
    view.stub(:pl){ t(:glossary,count:1)}
    render
  end 

  context "base layout" do
    subject{ Capybara.string(rendered) }

    context "title" do
      subject{ Capybara.string(rendered).h1 }
      its(:text){ should eq 'Edit Glossary' }
    end

    it{ should have_selector 'div.form.glossary' }
  end
end
