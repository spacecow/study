require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/inflections'
require './app/presenters/base_presenter'
require './app/presenters/glossary_presenter'

describe GlossaryPresenter do
  let(:glossary){ double :glossary }
  let(:view){ double :view }
  let(:presenter){ GlossaryPresenter.new glossary, view }

  describe ".sentences" do
    before do
      glossary.should_receive(:lookups).and_return lookups
      view.should_receive(:content_tag).with(:ul, class:'sentences').and_yield
    end
    subject{ presenter.sentences }

    context "without sentence" do
      let(:lookups){ [] }
      before{ view.should_not_receive(:render) }
      it("does not render any sentences"){ should be_nil }
    end

    context "with sentences" do
      let(:lookups){ [lookup] }
      let(:lookup){ create :lookup }
      before do
        view.should_receive(:render).
        with(lookups, glossaries:false, meaning:true)
      end
      it("does render sentences"){ should be_nil }
    end
  end
end
