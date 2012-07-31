require 'spec_helper'

describe "Project new" do
  before(:each) do
    signin_admin
    visit new_project_path
  end

  it "has a title" do
    page.should have_title('New Project')
  end

  it "has a filed for name" do
    value('* Name').should be_nil
  end
end

