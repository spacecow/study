require 'spec_helper'

describe 'sentences/index.html.erb' do
  let(:prince){ create :project, name:'Prince' }
  let(:general){ create :project, name:'General' }
  let(:sentence){ stub_model Sentence }
  before do
    controller.stub(:current_user){ create :user }
    assign(:projects, [[prince.name, prince.id],[general.name, general.id]])
    assign(:project_id, general.id)
    assign(:sentences, [sentence])
    render
  end

  subject{ Capybara.string(rendered) }
  it{ should have_selector 'h1', text:'Sentences' }
  it{ should have_selector 'ul.sentences' }

  describe "project selector" do
    before{ @sel = 'form' }
    subject{ Capybara.string(rendered).find(@sel) }
    it{ should have_button 'Go' }

    describe "project" do
      subject{ Capybara.string(rendered).find(@sel).find_field('Project')}
      its(:value){ should eq general.id.to_s }
    end 
  end

  describe "header" do
    subject{ Capybara.string(rendered).find('div.header a') }
    its(:text){ should eq 'New Sentence' }
  end

  describe "footer" do
    subject{ Capybara.string(rendered).find('div.footer a') }
    its(:text){ should eq 'New Sentence' }
  end
end
