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
end

describe "Sessions create" do
  context "logs a nonexisting user in" do
    before{ visit '/auth/facebook' }
    subject{ User }
    its(:count){ should eq 1 }
  end

  context "logs an existing user in" do
    before do
      FactoryGirl.create :user, provider:'facebook', uid:'123456'
      visit '/auth/facebook' 
    end
    subject{ User }
    its(:count){ should eq 1 }
  end

  it "redirects to wanted page after login" do
    user = FactoryGirl.create :user, provider:'facebook', uid:'123456'
    visit user_path(user) 
    visit '/auth/facebook' 
    page.current_path.should eq user_path(user)
  end
end
