require File.expand_path '../../../app/strategies/kuk', __FILE__

class Fitta
  include Kuk
end

describe Kuk do
  let(:fitta){ Fitta.new }

  describe "#question_params" do
    
    let(:english){ "yeah" }
    let(:japanese){ "ee" }
    before do
      fitta.should_receive(:english){ english }
      fitta.should_receive(:japanese){ japanese }
    end
    subject{ fitta.question_params }
    its([:string]){ should eq english }
    its([:correct]){ should eq japanese }

  end

end
