require 'spec_helper'

describe "Sessions destroy" do
  context "logout layout" do
    before(:each) do
      signin_member
    end

    it "has a signout link" do
      site_nav.should have_link('Sign out')
      click_link 'Sign out'
      site_nav.should have_link('Sign in')
    end
  end
end
