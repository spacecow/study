require 'spec_helper'

describe "Glossary show" do
  
  let(:glossary){ create :glossary, content:'trough', reading:"trɒf" }
  let(:sentence){ create :sentence, japanese:"the plants grew in troughs" }
  let(:sentence2){ create :sentence, japanese:"she was riding along the trough",
    project:sentence.project }
  let(:lookup){ create :lookup, glossary:glossary, sentence:sentence,
    meaning:'a container' }
  let(:lookup2){ create :lookup, glossary:glossary, sentence:sentence2,
    meaning:"a long hallow" }
  before do
    lookup; lookup2
    visit glossary_path glossary
  end
  subject{ page.text }

  it "glossary is rendered" do
    should include "trough"
    should include "trɒf"
    should include "the plants grew in troughs"
    should include "a container"
    should include "she was riding along the trough"
    should include "a long hallow"
  end
end
