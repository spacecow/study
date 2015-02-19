require 'spec_helper'

describe QuizzesController do

  describe "#new" do
    let(:method){ get :new }

    it "creates a quiz" do
      expect{ method }.to change(Quiz, :count).from(0).to(1)
    end

  end
end
