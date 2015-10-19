require './lib/masker'

describe Masker do

  describe ".combine" do
    subject{ Masker.combine sentences }
    
    context "one sentence" do
      let(:sentences){ ["* am legend"] }
      it{ should eq "* am legend" }
    end

    context "two sentences" do
      let(:sentences){ ["* am legend", "I ** legend"] }
      it{ should eq "* ** legend" }
    end

    context "three sentences" do
      let(:sentences){ ["* am legend", "I ** legend", "I am ******"] }
      it{ should eq "* ** ******" }
    end
  end

  describe ".mask" do
    let(:sentence){ "what the deuce" }
    subject{ Masker.mask sentence, word }
  
    context "mask one word" do
      let(:word){ "deuce" }
      it{ should eq 'what the *****' }
    end

    context "mask one word that is actually two" do
      let(:word){ "the deuce" }
      it{ should eq 'what *** *****' }
    end

    context "mask one of two words" do
      let(:word){ ["deuc","deuce"] }
      it{ should eq 'what the *****' }
    end

  end

end
