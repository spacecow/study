require 'spec_helper'

describe "sessions/new.html.erb" do
  before do
    render
  end

  subject{ Capybara.string(rendered) }
  it{ should have_selector 'h1', text:'Login' }
  it{ should have_button 'Login' }

  describe "Login" do
    subject{ Capybara.string(rendered).find_field 'Login' }
    its(:value){ should be_nil }
  end

  describe "Password" do
    subject{ Capybara.string(rendered).find_field 'Password' }
    its(:value){ should be_nil }
  end
end
