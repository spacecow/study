require 'spec_helper'

describe SentencesController do
  describe "#index" do
    context "with darkness" do
      let(:proj){create :project, name:'Darkness'}
      let!(:sentence){create :sentence, project:proj}

      context "all projects" do
        before{ get :index }
        context 'the sentences variable' do
          subject{ assigns(:sentences).map(&:project_name) }
          it{ should_not include 'Darkness' }
        end
      end # all projects

      context "project: Darkness" do
        before{ get :index, project_id:proj.id  }
        context 'the sentences variable' do
          subject{ assigns(:sentences).map(&:project_name) }
          it{ should include 'Darkness' }
        end
      end # all projects
    end # with darkness
  end # #index
end
