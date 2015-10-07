require File.expand_path '../../../app/strategies/kuk', __FILE__
require 'active_support/all'

class Fitta
  include Kuk
end

describe Kuk do
  let(:fitta){ Fitta.new }

  describe "#question_params" do
    
    let(:content){ "what the deuce" }
    before do
      fitta.should_receive(:english){ meaning }
      fitta.should_receive(:japanese){ content }
    end

    subject{ fitta.question_params.first }

    context "sentence has a meaning" do
      let(:meaning){ "what has happened" }
      its([:string]){ should eq "what has happened" }
      its([:correct]){ should eq "what the deuce" }
    end
    
    context "meaning is blank" do
      let(:meaning){ "" }
      it{ should be nil }
    end

    context "meaning is nil" do
      let(:meaning){ nil }
      it{ should be nil }
    end

  end

end
