require 'spec_helper'

describe "Project update" do
  before(:each) do
    project = FactoryGirl.create(:project, name:'alc')
    visit edit_project_path(project)
  end

  context 'create' do
    before(:each) do
      fill_in 'Name', with:'Prince'
      @project_no = Project.count
      click_button 'Update Project'
      @project = Project.last
    end

    it "saves no new project to the db" do
      Project.count.should be(@project_no)
    end

    it "has the name changed" do
      @project.name.should eq('Prince')
    end
  end

  context 'errors on' do
    it 'name not present' do
      fill_in 'Name', with:''
      click_button 'Update Project'
      div(:name).should have_blank_error
    end

    it 'name duplicated' do
      FactoryGirl.create(:project, name:'Prince')
      fill_in 'Name', with:'Prince'
      click_button 'Update Project'
      div(:name).should have_duplication_error
    end
  end
end
