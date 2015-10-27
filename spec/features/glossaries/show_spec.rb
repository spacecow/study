require 'spec_helper'

describe "Glossary show" do
  
  let(:glossary){ create :glossary, content:'trough',
    reading:"trɒf" }
  let(:container){ create :sentence,
    japanese:"plants grew in troughs" }
  let(:drain){ create :sentence,
    japanese:"walk in the trough", project:container.project }
  let(:lookup_container){ create :lookup, glossary:glossary,
    sentence:container, meaning:'a container' }
  let(:lookup_drain){ create :lookup, glossary:glossary,
    sentence:drain, meaning:"a long hallow" }

  let(:pot){ create :glossary, content:"pot" }
  let(:dirt){ create :glossary, content:"dirt" }
  let(:glas){ create :glossary, content:"glas" }
  let(:synonym_pot){ create :synonym_glossary,
    glossary:glossary, synonym:pot }
  let(:antonym_dirt){ create :antonym_glossary,
    glossary:glossary, antonym:dirt }
  let(:similar_glas){ create :similar_glossary,
    glossary:glossary, similar:glas }
  before do
    synonym_pot; antonym_dirt; similar_glas
    lookup_container; lookup_drain
    visit glossary_path glossary
  end
  subject{ page.text }

  it "glossary is rendered" do
    should include "trough"
    should include "trɒf"
    should include "plants grew in troughs"
    should include "a container"
    should include "walk in the trough"
    should include "a long hallow"
    should include "pot"
    should include "dirt"
    should include "glas"
  end
end
