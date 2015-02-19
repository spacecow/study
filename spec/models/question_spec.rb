describe Question do

  describe "create" do
    
    it "quiz id cannot be blank" do
      expect{Question.create}.to raise_error{|e|
        expect(e).to be_a ActiveRecord::StatementInvalid 
        expect(e.message).to match /'quiz_id' cannot be null/ }
    end

  end
end
