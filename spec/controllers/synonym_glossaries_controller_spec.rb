require 'spec_helper'

describe SynonymGlossariesController do
  describe "#destroy" do
    let(:relative){ create :synonym_glossary }
    before do
      session[:userid] = (create :user).id
      delete :destroy, id:relative.id, main:relative.glossary_id
    end

    describe SynonymGlossary do
      subject{ SynonymGlossary }
      its(:count){ should be 0 }
    end

    describe "response" do
      subject{ response }
      it{ should redirect_to glossary_path(relative.glossary)}
    end

    describe "flash" do
      subject{ flash }
      its(:notice){ should eq 'Relation deleted' }
    end
  end
end
