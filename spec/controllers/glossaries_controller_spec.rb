require 'spec_helper'

describe GlossariesController do
  describe "#update" do
    let(:glossary){ create :glossary }
    let(:second){ create :glossary }
    before{ session[:userid] = create(:user).id }

    context "add synonym" do
      before{ put :update, id:glossary.id, glossary:{synonym_tokens:second.id}}
      describe SynonymGlossary do
        subject{ SynonymGlossary }
        its(:count){ should be 1 }
      end
    end

    context "add similar" do
      before{ put :update, id:glossary.id, glossary:{similar_tokens:second.id}}
      describe SimilarGlossary do
        subject{ SimilarGlossary }
        its(:count){ should be 1 }
      end
    end

    context "add antonym" do
      before{ put :update, id:glossary.id, glossary:{antonym_tokens:second.id}}
      describe AntonymGlossary do
        subject{ AntonymGlossary }
        its(:count){ should be 1 }
      end
    end
  end
end

describe GlossariesController do
  controller_actions = controller_actions("glossaries")

  before(:each) do
    @model = FactoryGirl.create(:glossary)
  end

  describe "a user is not logged in" do
    controller_actions.each do |action,req|
      if %w(index show).include?(action)
        it "should reach the #{action} page" do
          send("#{req}", "#{action}", :id => @model.id)
          response.redirect_url.should_not eq root_url 
        end
      else
        it "should not reach the #{action} page" do
          send("#{req}", "#{action}", :id => @model.id)
          response.redirect_url.should eq root_url 
        end
      end
    end
  end

  context "a user is logged in as" do
    describe "member" do
      before(:each) do
        session[:userid] = create_member.id
      end

      controller_actions.each do |action,req|
        it "should reach the #{action} page" do
          send(req, action, :id => @model.id)
          response.redirect_url.should_not eq welcome_url
        end
      end
    end 

    describe "admin" do
      before(:each) do
        session[:userid] = create_admin.id
      end

      controller_actions.each do |action,req|
        it "should reach the #{action} page" do
          send(req, action, :id => @model.id)
          response.redirect_url.should_not eq welcome_url
        end
      end
    end 
  end
end
