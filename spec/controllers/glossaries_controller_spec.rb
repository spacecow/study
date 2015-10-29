# -*- coding: utf-8 -*-
require 'spec_helper'

describe GlossariesController do
  def send_put(content, reading)
    put :update, id:glossary.id, glossary:{content:content, reading:reading}
  end

  describe "#update" do
    let(:glossary){ create :glossary }
    let(:second){ create :glossary }
    before{ session[:userid] = create(:user).id }

    context "update" do
      before{ send_put('日本語', 'にほんご')}
      
      describe Glossary do
        subject{ Glossary }
        its(:count){ should be 1 } 
        # second is not initialized yet
      end

      describe "updated glossary" do
        subject{ Glossary.last }
        its(:content){ should eq '日本語' }
        its(:reading){ should eq 'にほんご' }
      end

      describe "response" do
        subject{ response }
        it{ should redirect_to glossary_path(glossary) }
      end

      describe "flash" do
        subject{ flash }
        its(:notice){ should eq 'Glossary updated' }
      end
    end

    context "error" do
      before{ send_put '', '' }

      describe "response" do
        subject{ response }
        it{ should render_template :edit }
      end
    end

    context "add lookup" do
      let(:sentence){ create :sentence }
      before{ put :update, id:glossary.id, glossary:{}}

      describe Lookup do
        subject{ Lookup }
        its(:count){ should be 0 } 
      end
    end

    context "add link between glossary & kanji" do
      let(:sentence){ create :sentence }
      let(:kanji){ create :kanji, symbol:'日' }
      before{ put :update, id:glossary.id, glossary:{content:'日本語', sentence_tokens:sentence.id}}

      describe GlossariesKanji do
        subject{ GlossariesKanji }
        it "should have a count of 1"
        #its(:count){ should be 1 } 
      end
    end 

    context "add synonym" do
      before{ put :update, id:glossary.id, glossary:{synonym_tokens:second.id}}
      describe SynonymGlossary do
        subject{ SynonymGlossary }
        its(:count){ should be 1 }
      end
    end

    context "add similar" do
      before{ put :update, id:glossary.id, glossary:{similar_tokens:second.id}}
      describe SimilarGlossary do
        subject{ SimilarGlossary }
        its(:count){ should be 1 }
      end
    end

    context "add antonym" do
      before{ put :update, id:glossary.id, glossary:{antonym_tokens:second.id}}
      describe AntonymGlossary do
        subject{ AntonymGlossary }
        its(:count){ should be 1 }
      end
    end
  end
end
