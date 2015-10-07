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
    
    context "meaning is blank without glossaries" do
      let(:meaning){ "" }
      before do
        fitta.should_receive(:glossaries){ [] }
      end
      it{ should be nil }
    end

    context "meaning is nil without glossaries" do
      let(:meaning){ nil }
      before do
        fitta.should_receive(:glossaries){ [] }
      end
      it{ should be nil }
    end

    context "meaning is blank with one glossary" do
      let(:meaning){ "" }
      let(:glossary){ double :glossary, content:'deuce', meaning:'even in tennis', reading:'du:s' }
      before do
        fitta.should_receive(:glossaries){ [glossary] }
      end
      its([:string]){ should eq "what the *****" }
      its([:content2]){ should eq "even in tennis" }
      its([:correct]){ should eq "deuce" }
      its([:reading]){ should eq "du:s" }
    end

  end

end
