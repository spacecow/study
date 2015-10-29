require './spec/helpers/factory_helper'
require './spec/helpers/database_helper'
require './spec/helpers/definition_helper'
require './spec/helpers/glossary_helper'
require './app/models/kanji'
require './app/models/glossaries_kanji'

describe Definition do

  describe "validations" do

    let(:glossary){ create :glossary } 
    let(:glossary_id){ glossary.id }
    subject{ -> {Definition.create glossary_id:glossary_id, content:"trough"} }

    context "definition is valid" do
      it{ should change(Definition, :count).from(0).to(1) } 
      after do
        Definition.delete_all
        Glossary.delete_all
      end
    end

    context "content is duplicated for different glossaries" do
      before{ create :definition, content:"trough" }
      it{ should change(Definition, :count).from(1).to(2) } 
      after do
        Definition.delete_all
        Glossary.delete_all
      end
    end

    context "content is duplicated for same glossary" do
      before{ create :definition, content:"trough", glossary_id:glossary_id }
      it{ should raise_error{|e|
        e.should be_a ActiveRecord::StatementInvalid
        e.message.should include "Duplicate entry" 
      }}
      after do
        Definition.delete_all
        Glossary.delete_all
      end
    end

    context "glossary_id is nil" do
      let(:glossary_id){ nil }
      it{ should raise_error{|e|
        e.should be_a ActiveRecord::StatementInvalid
        e.message.should include "cannot be null" 
      }}
    end

    context "glossary_id does not exist" do
      let(:glossary_id){ 1 }
      it{ should raise_error{|e|
        e.should be_a ActiveRecord::InvalidForeignKey
      }}
    end
  end

  describe "#tokens" do

    let(:glossary){ create :glossary, content:"trough" }
    let(:definition){ create :definition, content:"container", glossary:glossary }
    before{ definition }
    subject{ Definition.tokens(query).map{|e|
      [e[:id] , e[:content]] }}

    context "hit on glossary" do
      let(:query){ "ough" } 
      it{ should eq [
        [definition.id, "trough - container"],
        ["<<<ough>>>", "New: \"ough\""]
      ]}
    end

    context "hit on definition" do
      let(:query){ "contain" } 
      it{ should eq [
        [definition.id, "trough - container"],
        ["<<<contain>>>", "New: \"contain\""]
      ]}
    end

    context "no hit" do
      let(:query){ "jesus" } 
      it{ should eq [
        ["<<<jesus>>>", "New: \"jesus\""]
      ]}
    end

    context "hit on two definitions" do
      let(:query){ "cont" } 
      let(:definition2){ create :definition, content:"context", glossary:glossary }
      before{ definition2 } 
      it{ should eq [
        [definition.id, "trough - container"],
        [definition2.id, "trough - context"],
        ["<<<cont>>>", "New: \"cont\""]
      ]}
    end

    context "hit on two glossaries" do
      let(:query){ "ough" } 
      let(:glossary2){ create :glossary, content:"through" }
      let(:definition2){ create :definition, content:"pass", glossary:glossary2 } 
      before{ glossary2; definition2 } 
      it{ should eq [
        [definition.id, "trough - container"],
        [definition2.id, "through - pass"],
        ["<<<ough>>>", "New: \"ough\""]
      ]}
    end

    after do
      Definition.delete_all
      Glossary.delete_all
    end

  end
end
