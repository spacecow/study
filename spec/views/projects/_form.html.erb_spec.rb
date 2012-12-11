require 'spec_helper'

describe 'projects/_form.html.erb', focus:true do
  let(:project){ mock_model Project, name:'General' }
  before{ render 'projects/form', project:project }
  
  describe "Name" do
    subject{ Capybara.string(rendered).find_field 'Name'}
    its(:value){ should eq 'General' }
  end
end
