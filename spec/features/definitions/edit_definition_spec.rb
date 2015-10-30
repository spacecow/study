require 'spec_helper'

describe "edit definition" do

  it "" do
    definition = create :definition
    visit edit_definition_path(definition)
    fill_in "Definition", with:"edited definition"
    click_button "Update" 
    Definition.last.content.should eq "edited definition"
  end

end
