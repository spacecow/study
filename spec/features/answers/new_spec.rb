require 'spec_helper'

describe 'Answer new' do
  before{ signin_member }

  context "visit the new answer page" do
    it{ expect{ visit new_answer_path }.to raise_error ActiveRecord::RecordNotFound }
  end
end
