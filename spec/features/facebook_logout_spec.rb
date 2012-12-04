require 'spec_helper'

describe "Sessions destroy" do
  context "logout layout" do
    before(:each) do
      signin_member
    end

    it "has a signout link" do
      site_nav.should have_link('Signout')
      click_link 'Signout'
      site_nav.should have_link('Signin')
    end
  end
end
