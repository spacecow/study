require 'spec_helper'

describe User do
  describe "attributes" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it "provider exists" do
      @user.should respond_to :provider
    end
    it "uid exists" do
      @user.should respond_to :uid
    end
    it "username exists" do
      @user.should respond_to :username
    end
    it "name exists" do
      @user.should respond_to :name
    end
    it "email exists" do
      @user.should respond_to :email
    end
    it "oauth_token exists" do
      @user.should respond_to :oauth_token
    end
    it "oauth_expires_at exists" do
      @user.should respond_to :oauth_expires_at
    end
  end

  describe "#from_omniauth" do
    it "exists" do
      User.should respond_to :authenticate_from_omniauth
    end
  end
end

describe "Sessions create" do
  context "login layout" do
    before(:each) do
      visit root_path
    end

    it "has a facebook signin link" do
      site_nav.should have_link('Signin')
      click_link 'Signin'
      site_nav.should have_link('Signout')
    end
  end

  context "logs a nonexisting user in" do
    before(:each) do
      @user_count = User.count 
      visit '/auth/facebook' 
      @user = User.last
    end

    it "adds a user to the db" do
      User.count.should eq @user_count+1
    end
  end

  context "logs an existing user in" do
    before(:each) do
      FactoryGirl.create(:user, provider:'facebook', uid:'123456')
      @user_count = User.count 
      visit '/auth/facebook' 
      @user = User.last
    end

    it "adds a user to the db" do
      User.count.should eq @user_count
    end
  end

  it "redirects to wanted page after login" do
    user = FactoryGirl.create(:user, provider:'facebook', uid:'123456')
    visit user_path(user) 
    visit '/auth/facebook' 
    page.current_path.should eq user_path(user)
  end
end
