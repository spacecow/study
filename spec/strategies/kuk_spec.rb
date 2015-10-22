require './app/strategies/kuk'
require './lib/masker'
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
    
    context "no meaning" do
      before{ fitta.should_receive(:lookups){ lookups }}

      context "meaning is blank without glossaries" do
        let(:lookups){ [] }
        let(:meaning){ "" }
        it{ should be nil }
      end

      context "meaning is nil without glossaries" do
        let(:lookups){ [] }
        let(:meaning){ nil }
        it{ should be nil }
      end

      context "meaning is blank with one glossary" do
        let(:meaning){ "" }
        let(:lookup){ double :lookup, meaning:'even in tennis' }
        let(:glossary){ double :glossary, content:'deuce', all_forms:forms, reading:'du:s', sound_url:'yeah' }
        let(:lookups){ [lookup] }
        before{ lookup.should_receive(:glossary){ glossary }}

        context "glossary has one form" do
          let(:forms){ ["deuce"] } 
          its([:string]){ should eq "what the *****" }
          its([:content2]){ should eq "even in tennis" }
          its([:correct]){ should eq "deuce" }
          its([:reading]){ should eq "du:s" }
        end

        context "glossary has two form" do
          let(:forms){ ["deuc","deuce"] } 
          its([:string]){ should eq "what the *****" }
          its([:content2]){ should eq "even in tennis" }
          its([:correct]){ should eq "deuce" }
          its([:reading]){ should eq "du:s" }
        end
      end
    end

  end

end
