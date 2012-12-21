require 'spec_helper'

describe "layouts/_site_nav.html.erb" do
  describe "base layout" do
    before do
      view.should_receive(:current_user).and_return nil
      render 'layouts/site_nav'
    end

    context "second link" do
      subject{ Capybara.string(rendered).all('a')[1] }
      its(:text){ should eq 'Sentences' }
    end

    context "first link" do
      subject{ Capybara.string(rendered).all('a')[0] }
      its(:text){ should eq 'Glossaries' }
    end

  end

  context "guest user" do
    before do
      view.should_receive(:current_user).and_return nil
      render 'layouts/site_nav'
    end

    context "last link" do
      subject{ Capybara.string(rendered).all('a')[-1] }
      its(:text){ should eq 'Signin' }
      specify{ subject[:href].should eq '/auth/facebook' }
    end
  end

  context "member logged in" do
    before do
      view.should_receive(:current_user).and_return( create :user)
      render 'layouts/site_nav'
    end

    context "last link" do
      subject{ Capybara.string(rendered).all('a')[-1] }
      its(:text){ should eq 'Signout' }
      specify{ subject[:href].should eq signout_path }
    end
  end
end
