# -*- coding: utf-8 -*-
require 'spec_helper'

describe SentencesController do
  describe "#update" do
    let(:sentence){ create :sentence }
    before{ session[:userid] = create(:user).id }

    context "update" do
      let(:definition){ create :definition }
      before do
        Sentence.should_receive(:find).and_return sentence
        put :update, id:1, sentence:{japanese:'日本語', english:'Japanese', definition_tokens:definition.id}
      end

      describe Sentence do
        subject{ Sentence }
        its(:count){ should be 1 } 
      end

      describe "updated sentence" do
        subject{ Sentence.last }
        its(:japanese){ should eq '日本語' }
        its(:english){ should eq 'Japanese' }
      end

      describe Lookup do
        subject{ Lookup }
        its(:count){ should be 1 }
      end

      it "update glossary"

      describe "response" do
        subject{ response }
        it{ should redirect_to sentence_path(sentence) } 
      end

      describe "flash" do
        subject{ flash }
        its(:notice){ should eq 'Sentence updated' }
      end
    end
  end

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
