# -*- coding: utf-8 -*-
require 'spec_helper'

describe Glossary do
  describe "#ids_from_tokens" do
    context "string of ids" do
      it{ Glossary.ids_from_tokens("1,2").should eq %w(1 2) }
    end

    context "new glossary" do
      it{ Glossary.ids_from_tokens("<<<cat>>>").should eq [Glossary.last.id.to_s] }
    end

    context "existing glossary" do
      before{ create :glossary, content:'cat' }
      it{ lambda{ Glossary.ids_from_tokens("<<<cat>>>")}.should raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Content has already been taken')}
    end
  end

	describe "#link_kanjis" do
		let!(:day){ create :kanji, symbol:'日' }
		let!(:book){ create :kanji, symbol:'本' }

		describe "#create" do
			context "two new kanjis" do
				before { create :glossary, content:'日本' }

				describe GlossariesKanji do
					subject{ GlossariesKanji }
					its(:count){ should be 2 }
				end
			end
		end # #create

		describe "#update" do
			let(:glossary){ create :glossary, content:'日'}
			context "two kanjis, where one is old" do
				before{ glossary.update_attributes(content:'日本')}

				describe GlossariesKanji do
					subject{ GlossariesKanji }
					its(:count){ should be 2 }
				end
			end

			context "change kanji" do
				before{ glossary.update_attributes(content:'本')}
				describe GlossariesKanji do
					subject{ GlossariesKanji }
					its(:count){ should be 2 }
				end
			end
		end # update
	end # #link_kanjis
end
