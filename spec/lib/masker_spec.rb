require './lib/masker'

describe Masker do

  describe ".mask" do
    let(:sentence){ "what the deuce" }
    subject{ Masker.mask sentence, word }
  
    context "mask one word" do
      let(:word){ "deuce" }
      it{ should eq 'what the *****' }
    end

    context "mask one of two words" do
      let(:word){ ["deuc","deuce"] }
      it{ should eq 'what the *****' }
    end

  end

end
