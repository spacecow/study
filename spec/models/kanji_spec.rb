# -*- coding: utf-8 -*-
require 'spec_helper'

describe Kanji do
  describe ".kanji_array" do
    context "empty string" do
      subject{ Kanji.kanji_array "" }
      it{ should be_empty }
    end

    context "nil string" do
      subject{ Kanji.kanji_array nil }
      it{ should be_empty }
    end

    context "one kanji" do
      before{ Kanji.should_receive(:exists?).once.and_return true }
      subject{ Kanji.kanji_array '日' }
      it{ should eq ['日']}
    end

    context "two kanjis" do
      before{ Kanji.should_receive(:exists?).twice.and_return true }
      subject{ Kanji.kanji_array '日本' }
      it{ should eq ['日', '本']}
    end

    context "two kanjis, where one isn't recognized" do
      before do
        Kanji.should_receive(:exists?).with({symbol:'日'}).once.and_return true
        Kanji.should_receive(:exists?).with({symbol:'本'}).once.and_return false
      end

      subject{ Kanji.kanji_array '日本' }
      it{ should eq ['日']}
    end
  end

  describe "#random_glossary" do
    let(:kanji){ create Kanji }

    context "no glossaries" do
      specify{ kanji.random_glossary.should be_nil }
    end

    context "one glossary" do
      before{ kanji.should_receive(:glossaries).once.and_return ['glossary'] }
      subject{ kanji.random_glossary }
      it{ should eq 'glossary' }
    end

    context "one that is already taken" do
      let(:glossary){ mock :glossary }
      before{ kanji.should_receive(:glossaries).once.and_return [glossary] }
      specify{ kanji.random_glossary(glossary).should be_nil }
    end

    context "two" do
      before{ kanji.should_receive(:glossaries).exactly(10).times.and_return %w(glossary1 glossary2) }
      it "randomizes the glossary" do
        count = 0
        10.times do
          count += 1 if kanji.random_glossary == 'glossary1'
        end
        count.should_not eq 10
        count.should_not eq 0
      end
    end

    context "two, where glossary1 is taken" do
      let(:glossary1){ mock :glossary }
      before{ kanji.should_receive(:glossaries).once.and_return [glossary1, 'glossary2'] }
      subject{ kanji.random_glossary(glossary1) }
      it{ should eq 'glossary2' }
    end
  end

  describe "#generate_db" do
    #it "saves them all to db", slow:true do
    #  lambda do
    #    lambda do
    #      Kanji.generate_db
    #    end.should change(Kanji, :count).by(6355)
    #  end.should change(Meaning, :count).by(8507)
    #end

    context "one kanji" do
      before(:each) do
        @kanji_no = Kanji.count
        @meaning_no = Meaning.count
        Kanji.generate_db('kanjidic_one.utf')
        @kanji = Kanji.last
      end

      it "saves them to db" do
        Kanji.count.should be(@kanji_no+1)
      end

      it "saves the kanjis meanings" do
        Meaning.count.should be(@meaning_no+4)
      end

      it "links the meanings to the kanji" do
        @kanji.meanings.map(&:name).should eq(["-ous", "come after", "rank next", "Asia"])
      end
    end
  end

  context "create" do
    before(:each) do
      @kanji_count = Kanji.count
      FactoryGirl.create(:kanji)
    end

    it "saves to db" do
      Kanji.count.should eq @kanji_count+1
    end

    it "blank, no save to db" do
      lambda{ FactoryGirl.create(:kanji, symbol:'')
      }.should raise_error(ActiveRecord::RecordInvalid)
    end

    it "douplet, no save to db" do
      lambda{ FactoryGirl.create(:kanji)
      }.should raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
