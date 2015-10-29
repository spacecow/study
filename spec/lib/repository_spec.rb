require './spec/helpers/database_helper'
require './spec/helpers/factory_helper'
require './spec/helpers/sentence_helper'
require './spec/helpers/user_helper'
require './spec/helpers/glossary_helper'
require './spec/helpers/project_helper'
require './app/models/kanji'
require './app/models/glossaries_kanji'
require './app/models/lookup'
require './lib/repository'

describe Repository do
  let(:mdl){ Repository.new }

  describe "#update_sentence" do
    let(:sentence){ create :sentence }
    let(:glossary){ create :glossary } 
    let(:lookup){ create :lookup, sentence:sentence, glossary:glossary }
    let(:glossary_tokens){ "<<<魔法>>>" }
    let(:params){{ glossary_tokens:glossary_tokens }}
    before{ lookup }
    subject{ mdl.update_sentence sentence:sentence, params:params }

    it "change to a new glossary" do
      Sentence.count.should be 1 
      Lookup.count.should be 1 
      Glossary.count.should be 1 
      subject
      Sentence.count.should be 1 
      Lookup.count.should be 1 
      Glossary.count.should be 2 
    end

    context do
      let(:glossary2){ create :glossary }
      let(:glossary_tokens){ glossary2.id.to_s }
      before{ glossary2 }
      it "change to a pre-existing glossary" do
        Sentence.count.should be 1 
        Lookup.count.should be 1 
        Glossary.count.should be 2 
        subject
        Sentence.count.should be 1 
        Lookup.count.should be 1 
        Glossary.count.should be 2 
      end
    end

    after do
      Project.delete_all
      Sentence.delete_all
      Lookup.delete_all
      Glossary.delete_all
    end
  end

  describe "#create_sentence" do
    let(:user){ create :user }
    let(:glossary_tokens){ "<<<魔法>>>" }
    let(:params){{ glossary_tokens:glossary_tokens, project_id:1 }}

    subject{ mdl.create_sentence user:user, params:params }

    it "bind to new glossary" do
      Sentence.count.should be 0 
      Lookup.count.should be 0 
      Glossary.count.should be 0 
      subject
      Sentence.count.should be 1 
      Lookup.count.should be 1 
      Glossary.count.should be 1 
    end

    context do 
      let(:glossary){ create :glossary }
      let(:glossary_tokens){ glossary.id.to_s }
      before{ glossary }

      it "bind to pre-existing glossary" do
        Sentence.count.should be 0 
        Lookup.count.should be 0 
        Glossary.count.should be 1 
        subject
        Sentence.count.should be 1 
        Lookup.count.should be 1 
        Glossary.count.should be 1 
      end
    end

    after do
      Sentence.delete_all
      Lookup.delete_all
      Glossary.delete_all
      User.delete_all
    end
  end

end
