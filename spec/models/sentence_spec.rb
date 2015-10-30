require './spec/helpers/factory_helper'
require './spec/helpers/database_helper'
require './spec/helpers/sentence_helper'
require './spec/helpers/lookup_helper'
require './spec/helpers/definition_helper'
require './spec/helpers/glossary_helper'
require './spec/helpers/kanji_helper'
require './spec/helpers/glossaries_kanji_helper'
require './spec/helpers/project_helper'

describe Sentence do
  let(:mdl){ create :sentence }
  subject{ mdl.send function }

  describe "#definitions_prepopulate" do
    let(:function){ :definitions_prepopulate }
    let(:glossary){ create :glossary, content:"trough" }
    let(:definition){ create :definition, glossary:glossary, content:"container" }
    let(:lookup){ create :lookup, sentence:mdl, definition:definition }

    before{ lookup }

    subject{ mdl.send(function).map{|e|{ id:e.id,content:e.content }}}

    it{ subject.should eq [{id:definition.id, content:"trough - container"}] } 

    after do
      Project.delete_all
      Lookup.delete_all
      Definition.delete_all
      Sentence.delete_all
      Glossary.delete_all 
    end
  end
    
end
