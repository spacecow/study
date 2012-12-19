# -*- coding: utf-8 -*-
require 'spec_helper'

describe KanjisController do
  def send_put(similar_id='')
    put :update, id:kanji.id, kanji:{similar_tokens:similar_id}
  end

  describe "#update" do
    let(:kanji){ create :kanji }
    before do
			session[:userid] = create_member.id
    end

    context "update" do
      before{ send_put }

      describe Kanji do
        subject{ Kanji }
        its(:count){ should be 1 }
      end

      describe Similarity do
        let(:similar){ create :kanji, symbol:'同' }
        before{ send_put(similar.id) }

        subject{ Similarity }
        its(:count){ should be 1 }

        describe "created similarity" do
          subject{ Similarity.last }
          its(:kanji_id){ should be kanji.id }
          its(:similar_id){ should be similar.id }
        end
      end

      describe "response" do
        subject{ response }
        it{ should redirect_to kanji_path(kanji) }
      end

      describe "flash" do
        subject{ flash }
        its(:notice){ should eq 'Kanji updated' } 
      end
    end
  end # #update
end
