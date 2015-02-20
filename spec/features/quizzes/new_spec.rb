require 'spec_helper'

describe 'Quiz new' do
  before do
    signin_member
    create :sentence
    visit new_quiz_path
  end

  context "visit the new quiz page" do
    describe "page text" do
      subject{ page.text }
      it{ should_not match /error/i }
    end
    describe "current path" do
      subject{ current_path }
      it{ should eq new_answer_path }
    end
  end

  context "go to the next question" do
    before{ click_button 'next' }
    describe "page text" do
      subject{ page.text }
      it{ should_not match /error/i }
    end
  end

  context "go to the next-next question" do
    before do
      click_button 'next'
      click_button 'next'
    end
    describe "page text" do
      subject{ page.text }
      it{ should_not match /error/i }
    end
  end


end
