require 'spec_helper'

describe SynonymGlossaryPresenter do
  let(:glossary){ mock_model Glossary }
  let(:relative){ mock_model SynonymGlossary }
  let(:presenter){ SynonymGlossaryPresenter.new(relative,glossary,view)}

  describe '.actions', focus:true do
    let(:user){ create :user }
    let(:rendered){ Capybara.string(presenter.actions)}
    before do
      @selector = "span.actions"
      controller.stub(:current_user){ user }
    end

    context "delete link" do
      before{ @selector += ' a' }
      subject{ rendered.find(@selector) }
      its(:text){ should eq 'Delete' }
      specify{ subject[:href].should eq synonym_glossary_path(relative,main:glossary) }
      specify{ subject['data-method'].should eq 'delete' }
    end
  end # .content
end
