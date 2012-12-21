require 'spec_helper'

describe "similarities/_similarity.html.erb" do
  let(:demon){ stub_model Kanji }
  let(:devil){ stub_model Kanji }
  let(:similarity){ stub_model Similarity, kanji:demon, similar:devil }
  before do
    controller.stub(:current_user){ create :user }
    render similarity, main:demon
  end

  subject{ Capybara.string(rendered) }
  it{ should have_selector 'span.character' }
  it{ should have_selector 'span.meanings' }
  it{ should have_selector 'span.actions' }
end
