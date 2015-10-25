require './spec/helpers/model_helper'
require './app/models/lookup'

describe Lookup do
  let(:mdl){ Lookup.new }
  subject{ mdl.send function }

  describe "#synonym_titles" do
    let(:function){ :synonym_titles }
    let(:glossary){ double :glossary }

    before do
      mdl.should_receive(:glossary){ glossary }
      glossary.should_receive(:synonym_titles){ :arr }
    end

    context "glossary has no synonyms" do
      it{ should eq :arr }
    end
  end
end
