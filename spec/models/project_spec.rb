require 'spec_helper'

describe Project do
  describe "validations" do
    context "blank name" do
      it{ lambda{ create :project, name:'' }.should raise_error ActiveRecord::RecordInvalid, 'Validation failed: Name can\'t be blank'}  
    end

    context "duplicated name" do
      before{ create :project, name:'Prince' }
      it{ lambda{ create :project, name:'Prince' }.should raise_error ActiveRecord::RecordInvalid, 'Validation failed: Name has already been taken'}  
    end
  end
end
