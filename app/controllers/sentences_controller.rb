class SentencesController < ApplicationController
  def index
    @sentences = Sentence.all
  end

  def new
    @sentence = Sentence.new
    @sentence.glossaries.build
  end

  def create
    @sentence = Sentence.new(params[:sentence])
    if @sentence.save
      redirect_to new_sentence_path
    end
  end

  def edit
    @sentence = Sentence.find(params[:id])
  end

  def update
    @sentence = Sentence.find(params[:id])
    if @sentence.update_attributes(params[:sentence])
      redirect_to sentences_path
    end
  end
end
