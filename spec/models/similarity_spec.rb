require 'spec_helper'

describe Similarity do
  let(:demon){ mock_model Kanji }
  let(:devil){ mock_model Kanji }
  let(:similarity){ stub_model Similarity, kanji:demon, similar:devil }
  describe "#secondary" do
    it{ similarity.secondary(demon).should eq devil }
    it{ similarity.secondary(devil).should eq demon }
  end
end
