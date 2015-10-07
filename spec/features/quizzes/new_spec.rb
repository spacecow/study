require 'spec_helper'

describe 'Quiz new' do
  before do
    signin_member
    project = create :project
    create :sentence, english:'first real question',
      japanese:'first', project:project
    create :sentence, english:'second real question',
      japanese:'second', project:project
    create :sentence, english:'third real question',
      japanese:'third', project:project
    visit new_quiz_path
  end

  context "visit the new quiz page" do
    describe "page text" do
      subject{ page.text }
      it{ should_not match /error/i }
      it{ should match /real question/ }
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
      it{ should match /real question/ }
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
      it{ should match /real question/ }
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
