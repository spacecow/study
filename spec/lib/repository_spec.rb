require './spec/helpers/database_helper'
require './spec/helpers/factory_helper'
require './spec/helpers/sentence_helper'
require './spec/helpers/user_helper'
require './spec/helpers/glossary_helper'
require './spec/helpers/project_helper'
require './app/models/kanji'
require './app/models/glossaries_kanji'
require './app/models/lookup'
require './spec/helpers/definition_helper'
require './lib/repository'

describe Repository do
  let(:mdl){ Repository.new }

  describe "#update_sentence" do
    let(:sentence){ create :sentence }
    #let(:glossary){ create :glossary } 
    let(:definition){ create :definition }
    let(:lookup){ create :lookup, sentence:sentence, definition:definition }
    let(:definition_tokens){ "<<<trough - container>>>" }
    let(:params){{ definition_tokens:definition_tokens }}
    before{ lookup }
    subject{ mdl.update_sentence sentence:sentence, params:params }

    it "change to a new glossary & definition" do
      Sentence.count.should be 1 
      Lookup.count.should be 1 
      Glossary.count.should be 1 
      Definition.count.should be 1
      subject
      Sentence.count.should be 1 
      Lookup.count.should be 1 
      Glossary.count.should be 2 
      Definition.count.should be 2 
      Glossary.last.content.should eq "trough" 
      Definition.last.content.should eq "container" 
    end

    context do
      let(:definition_tokens){ "<<<trough>>>" }
      it "change to a new glossary & empty definition" do
        Sentence.count.should be 1 
        Lookup.count.should be 1 
        Glossary.count.should be 1 
        Definition.count.should be 1
        subject
        Sentence.count.should be 1 
        Lookup.count.should be 1 
        Glossary.count.should be 2 
        Definition.count.should be 2 
        Glossary.last.content.should eq "trough" 
        Definition.last.content.should be_blank 
      end
    end

    context do
      let(:glossary2){ create :glossary, content:"trough" }
      before{ glossary2 }
      it "change to existing glossary & new definition" do
        Sentence.count.should be 1 
        Lookup.count.should be 1 
        Glossary.count.should be 2 
        Definition.count.should be 1 
        subject
        Sentence.count.should be 1 
        Lookup.count.should be 1 
        Glossary.count.should be 2 
        Definition.count.should be 2 
        Glossary.last.content.should eq "trough" 
        Definition.last.content.should eq "container" 
      end
    end

    context do
      let(:definition2){ create :definition }
      let(:definition_tokens){ definition2.id.to_s }
      before{ definition2 }
      it "change to a pre-existing glossary & definition" do
        Sentence.count.should be 1 
        Lookup.count.should be 1 
        Glossary.count.should be 2 
        Definition.count.should be 2 
        subject
        Sentence.count.should be 1 
        Lookup.count.should be 1 
        Glossary.count.should be 2 
        Definition.count.should be 2 
      end
    end

    after do
      Definition.delete_all
      Project.delete_all
      Sentence.delete_all
      Lookup.delete_all
      Glossary.delete_all
    end
  end

  describe "#create_sentence" do
    let(:user){ create :user }
    let(:definition_tokens){ "<<<trough>>>" }
    let(:params){{ project_id:1, definition_tokens:definition_tokens }}

    subject{ mdl.create_sentence user:user, params:params }

    it "bind to new glossary & empty definition" do
      Sentence.count.should be 0 
      Lookup.count.should be 0 
      Glossary.count.should be 0 
      Definition.count.should be 0 
      subject
      Sentence.count.should be 1 
      Lookup.count.should be 1 
      Glossary.count.should be 1 
      Glossary.last.content.should eq "trough" 
      Definition.count.should be 1 
      Definition.last.content.should be_blank
    end

    context do 
      let(:definition_tokens){ "<<<trough - container>>>" }
      it "bind to new glossary & definition" do
        Sentence.count.should be 0 
        Lookup.count.should be 0 
        Glossary.count.should be 0 
        Definition.count.should be 0 
        subject
        Sentence.count.should be 1 
        Lookup.count.should be 1 
        Glossary.count.should be 1 
        Glossary.last.content.should eq "trough" 
        Definition.count.should be 1 
        Definition.last.content.should eq "container" 
      end
    end

    context do 
      let(:glossary){ create :glossary, content:"trough" }
      let(:definition_tokens){ "<<<trough - container>>>" }
      before{ glossary } 
      it "bind to existing glossary & new definition" do
        Sentence.count.should be 0 
        Lookup.count.should be 0 
        Glossary.count.should be 1 
        Definition.count.should be 0 
        subject
        Sentence.count.should be 1 
        Lookup.count.should be 1 
        Glossary.count.should be 1 
        Glossary.last.content.should eq "trough" 
        Definition.count.should be 1 
        Definition.last.content.should eq "container" 
      end
    end

    context do 
      let(:definition){ create :definition }
      let(:definition_tokens){ definition.id.to_s }
      before{ definition }

      it "bind to pre-existing glossary & definition" do
        Sentence.count.should be 0 
        Lookup.count.should be 0 
        Glossary.count.should be 1 
        Definition.count.should be 1 
        subject
        Sentence.count.should be 1 
        Lookup.count.should be 1 
        Glossary.count.should be 1 
        Definition.count.should be 1 
      end
    end

    after do
      Definition.delete_all
      Sentence.delete_all
      Lookup.delete_all
      Glossary.delete_all
      User.delete_all
    end
  end

end
