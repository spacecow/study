require 'cancan/matchers'

describe Ability do
  glossary_actions = controller_actions("glossaries")
  sentence_actions = controller_actions("sentences")
  kanji_actions = controller_actions("kanjis")
  project_actions = controller_actions("projects")
  user_actions = controller_actions("users")

  synonym_glossary_actions = controller_actions("synonym_glossaries")
  similar_glossary_actions = controller_actions("similar_glossaries")
  antonym_glossary_actions = controller_actions("antonym_glossaries")

  describe "a guest is" do
    subject { Ability.new( nil )}
    project_actions.each do |action,req|
      if false #%(index show).include? action
        it "able to #{action} project" do
          should be_able_to action.to_sym, Project
        end
      else
        it "not able to #{action} project" do
          should_not be_able_to action.to_sym, Project
        end
      end
    end
    user_actions.each do |action,req|
      if false #%(index show).include? action
        it "able to #{action} user" do
          should be_able_to action.to_sym, User
        end
      else
        it "not able to #{action} user" do
          should_not be_able_to action.to_sym, User
        end
      end
    end
    synonym_glossary_actions.each do |action,req|
      if false #%(index show).include? action
        it "able to #{action} synonym glossary" do
          should be_able_to action.to_sym, SynonymGlossary
        end
      else
        it "not able to #{action} synonym glossary" do
          should_not be_able_to action.to_sym, SynonymGlossary
        end
      end
    end
    similar_glossary_actions.each do |action,req|
      if false #%(index show).include? action
        it "able to #{action} similar glossary" do
          should be_able_to action.to_sym, SimilarGlossary
        end
      else
        it "not able to #{action} similar glossary" do
          should_not be_able_to action.to_sym, SimilarGlossary
        end
      end
    end
    antonym_glossary_actions.each do |action,req|
      if false #%(index show).include? action
        it "able to #{action} antonym glossary" do
          should be_able_to action.to_sym, AntonymGlossary
        end
      else
        it "not able to #{action} antonym glossary" do
          should_not be_able_to action.to_sym, AntonymGlossary
        end
      end
    end
    glossary_actions.each do |action,req|
      if %(index show).include? action
        it "able to #{action} glossary" do
          should be_able_to action.to_sym, Glossary
        end
      else
        it "not able to #{action} glossary" do
          should_not be_able_to action.to_sym, Glossary
        end
      end
    end
    sentence_actions.each do |action,req|
      if %(index show).include? action
        it "able to #{action} sentence" do
          should be_able_to action.to_sym, Sentence
        end
      else
        it "not able to #{action} sentence" do
          should_not be_able_to action.to_sym, Sentence
        end
      end
    end
    kanji_actions.each do |action,req|
      if %(index show).include? action
        it "able to #{action} kanji" do
          should be_able_to action.to_sym, Kanji
        end
      else
        it "not able to #{action} kanji" do
          should_not be_able_to action.to_sym, Kanji
        end
      end
    end
  end

  describe "a member is" do
    subject { Ability.new( create_member )}
    project_actions.each do |action,req|
      if false #%(index show).include? action
        it "able to #{action} project" do
          should be_able_to action.to_sym, Project
        end
      else
        it "not able to #{action} project" do
          should_not be_able_to action.to_sym, Project
        end
      end
    end
    user_actions.each do |action,req|
      if %(show).include? action
        it "able to #{action} user" do
          should be_able_to action.to_sym, User
        end
      else
        it "not able to #{action} user" do
          should_not be_able_to action.to_sym, User
        end
      end
    end
    synonym_glossary_actions.each do |action,req|
      if %(destroy).include? action
        it "able to #{action} synonym glossary" do
          should be_able_to action.to_sym, SynonymGlossary
        end
      else
        it "not able to #{action} synonym glossary" do
          should_not be_able_to action.to_sym, SynonymGlossary
        end
      end
    end
    similar_glossary_actions.each do |action,req|
      if %(destroy).include? action
        it "able to #{action} similar glossary" do
          should be_able_to action.to_sym, SimilarGlossary
        end
      else
        it "not able to #{action} similar glossary" do
          should_not be_able_to action.to_sym, SimilarGlossary
        end
      end
    end
    antonym_glossary_actions.each do |action,req|
      if %(destroy).include? action
        it "able to #{action} antonym glossary" do
          should be_able_to action.to_sym, AntonymGlossary
        end
      else
        it "not able to #{action} antonym glossary" do
          should_not be_able_to action.to_sym, AntonymGlossary
        end
      end
    end
    glossary_actions.each do |action,req|
      if %(index show new create edit update).include? action
        it "able to #{action} glossary" do
          should be_able_to action.to_sym, Glossary
        end
      else
        it "not able to #{action} glossary" do
          should_not be_able_to action.to_sym, Glossary
        end
      end
    end
    sentence_actions.each do |action,req|
      if %(index show new create edit update).include? action
        it "able to #{action} sentence" do
          should be_able_to action.to_sym, Sentence
        end
      else
        it "not able to #{action} sentence" do
          should_not be_able_to action.to_sym, Sentence
        end
      end
    end
    kanji_actions.each do |action,req|
      if %(index show edit update).include? action
        it "able to #{action} kanji" do
          should be_able_to action.to_sym, Kanji
        end
      else
        it "not able to #{action} kanji" do
          should_not be_able_to action.to_sym, Kanji
        end
      end
    end
  end

  describe "an admin is" do
    subject { Ability.new( create_admin )}
    user_actions.each do |action,req|
      it "able to #{action} user" do
        should be_able_to action.to_sym, User
      end
    end
    synonym_glossary_actions.each do |action,req|
      it "able to #{action} synonym glossary" do
        should be_able_to action.to_sym, SynonymGlossary
      end
    end
    similar_glossary_actions.each do |action,req|
      it "able to #{action} similar glossary" do
        should be_able_to action.to_sym, SimilarGlossary
      end
    end
    antonym_glossary_actions.each do |action,req|
      it "able to #{action} antonym glossary" do
        should be_able_to action.to_sym, AntonymGlossary
      end
    end
    glossary_actions.each do |action,req|
      it "able to #{action} glossary" do
        should be_able_to action.to_sym, Glossary
      end
    end
    sentence_actions.each do |action,req|
      it "able to #{action} sentence" do
        should be_able_to action.to_sym, Sentence
      end
    end
    kanji_actions.each do |action,req|
      it "able to #{action} kanji" do
        should be_able_to action.to_sym, Kanji
      end
    end
    project_actions.each do |action,req|
      it "able to #{action} project" do
        should be_able_to action.to_sym, Project
      end
    end
#index, update, show, edit
  end
end
