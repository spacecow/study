require 'spec_helper'

describe SentencesController do
  controller_actions = controller_actions("sentences")

  before(:each) do
    @model = FactoryGirl.create(:sentence)
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
