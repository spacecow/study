require 'spec_helper'

describe SimilaritiesController do
  describe "#destroy" do
    let(:kanji){ create :kanji }
    let(:similarity){ create :similarity }
    before do
      session[:userid] = (create :user).id
      delete :destroy, id:similarity.id, main_id:kanji.id
    end 
    
    describe Similarity do
      subject{ Similarity }
      its(:count){ should be 0 }
    end

    describe "response" do
      subject{ response }
      it{ should redirect_to kanji_path(kanji) }
    end
  end
end
