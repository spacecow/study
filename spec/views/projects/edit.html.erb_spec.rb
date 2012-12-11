require 'spec_helper'

describe 'projects/edit.html.erb' do
  before do
    assign(:project, mock_model(Project))
    render
  end

  subject{ Capybara.string(rendered)}
  it{ should have_selector 'h1', text:'Edit Project' }
  it{ should have_selector 'form.edit_project' }
end
