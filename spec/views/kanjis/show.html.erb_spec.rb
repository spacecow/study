require 'spec_helper'

describe 'kanjis/show.html.erb' do
  before do
    controller.stub(:current_user){ create :user }
    assign(:kanji, mock_model(Kanji).as_null_object)
    render 
  end

  describe "base layout" do
    subject{ Capybara.string(rendered)}
    it{ should have_selector 'h1' } 
    it{ should have_selector 'div.meanings' }
    it{ should have_selector 'div.similars.kanjis' }
  end
end
