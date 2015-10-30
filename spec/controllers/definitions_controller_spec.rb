class ApplicationController; end
require './app/controllers/definitions_controller'

describe DefinitionsController do
  let(:controller){ DefinitionsController.new }
  let(:repo){ double :repo }
  let(:params){{id: :id, definition: :params}}

  before do
    controller.stub(:repo){ repo }
    controller.stub(:params){ params }
  end
  subject{ controller.send function }

  describe "#edit" do
    let(:function){ :edit }
    before do
      repo.should_receive(:definition).with(:id){ :definition }
    end
    it{ subject.should eq :definition }
  end

  describe "#update" do
    let(:function){ :update }
    let(:definition){ double :definition }
    before do
      controller.should_receive(:redirect_to).with(:glossary){ :redirect }
      repo.should_receive(:definition).with(:id){ definition }
      repo.should_receive(:update_definition).with(definition, :params)
      definition.should_receive(:glossary){ :glossary }
    end
    it{ subject.should eq :redirect }
  end

end
