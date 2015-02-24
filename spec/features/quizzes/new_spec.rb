require 'spec_helper'

describe 'Quiz new' do
  before do
    signin_member
    project = create :project
    create :sentence, english:'first question',
      project:project
    create :sentence, english:'second question',
      project:project
    create :sentence, english:'third question',
      project:project
    visit new_quiz_path
  end

  context "visit the new quiz page" do
    describe "page text" do
      subject{ page.text }
      it{ should_not match /error/i }
      it{ should match /first question/ }
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
      it{ should match /second question/ }
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
      it{ should match /third question/ }
    end
  end

  context "finish the quiz" do
    before do
      click_button 'next'
      click_button 'next'
      click_button 'next'
    end
    describe "page text" do
      subject{ page.text }
      it{ should_not match /error/i }
      it{ should match /YEAH/ }
    end
  end


end
