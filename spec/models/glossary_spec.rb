require './spec/helpers/model_helper'
require './spec/helpers/glossary_helper'

describe Glossary do
  let(:mdl){ Glossary.new }
  subject{ mdl.send function, params }

  describe "#meaning" do
    let(:function){ :meaning }
    let(:params){ "contempt" } 

    let(:titles){ ["disdain"] }
    before do
      mdl.should_receive(:synonym_titles){ titles }
    end

    context "glossary has no synonyms" do
      let(:titles){ [] }
      it{ should eq "contempt" }
    end

    context "glossary has synonyms" do
      it{ should eq "contempt; disdain" }
    end
  end
end
