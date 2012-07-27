require 'spec_helper'

describe "Project create" do
  before(:each) do
    visit new_project_path
  end

  context "success" do
    before(:each) do
      fill_in 'Name', with:'Prince'
      @project_no = Project.count
      click_button 'Create Project'
      @project = Project.last
    end

    it "saves the project to the db" do
      Project.count.should be(@project_no+1)
    end

    it "has its name saved" do
      @project.name.should eq('Prince')
    end
  end

  context "errors on" do
    it "name, not present" do
      fill_in 'Name', with:''
      click_button 'Create Project'  
      div(:name).should have_blank_error
    end

    it "name, not unique" do
      FactoryGirl.create(:project, name:'Prince')
      fill_in 'Name', with:'Prince'
      click_button 'Create Project'  
      div(:name).should have_duplication_error
    end
  end
end

