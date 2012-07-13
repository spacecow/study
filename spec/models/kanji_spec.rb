require 'spec_helper'

describe Kanji do
  #describe "#generate_db" do
  #  it "saves them all to db", slow:true do
  #    lambda{ Kanji.generate_db
  #    }.should change(Kanji, :count).by(6355)
  #  end
  #end

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
