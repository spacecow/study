# -*- coding: utf-8 -*-
require 'spec_helper'

describe SimilarityPresenter do
  let(:demon){ mock_model Kanji }
  let(:devil){ mock_model Kanji }
  let(:similarity){ mock_model Similarity }
  let(:presenter){ SimilarityPresenter.new(similarity,demon,view)}

  describe '#actions' do
    before{ controller.stub(:current_user){ create :user }}
    let(:rendered){ Capybara.string(presenter.actions)}
    subject{ rendered }
    its(:text){ should eq 'Delete' }

    describe "link" do
      subject{ rendered.find('a') }
      its(:text){ should eq 'Delete' }
      specify{ subject[:href].should eq similarity_path(similarity, main_id:demon)} 
      specify{ subject['data-method'].should eq 'delete' }
    end
  end

  describe '#meanings' do
    let(:meaning){ mock_model Meaning }
    before do
      meaning.should_receive('name').and_return 'devil'
      similarity.should_receive('secondary_meanings').with(demon).and_return [meaning]
    end

    let(:rendered){ Capybara.string(presenter.meanings) }
    subject{ rendered }
    its(:text){ should eq 'devil' }

    describe "link" do
      subject{ rendered.find('a') }
      its(:text){ should eq 'devil' }
      specify{ subject[:href].should eq meaning_path(meaning)} 
    end
  end

  describe '#character' do 
    before do
      similarity.should_receive('secondary_character').and_return '鬼'
      similarity.should_receive('secondary').and_return devil
    end

    let(:rendered){ Capybara.string(presenter.character) }
    subject{ rendered }
    its(:text){ should eq '鬼' }

    describe "link" do
      subject{ rendered.find('a') }
      its(:text){ should eq '鬼' }
      specify{ subject[:href].should eq kanji_path(devil)} 
    end
  end
end
