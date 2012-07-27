require 'spec_helper'

describe "Project edit" do
  before(:each) do
    project = FactoryGirl.create(:project)
    visit edit_project_path(project)
  end

  it "has a title" do
    page.should have_title('Edit Project')
  end

  it "has a filed for name" do
    value('* Name').should eq('Factory Name')
  end
end

