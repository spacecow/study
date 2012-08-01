require 'spec_helper'

describe Kanji do
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
