class SentencesController < ApplicationController
  load_and_authorize_resource

  def show
    @sentence = Sentence.find(params[:id])
  end

  def index
    @sentences = Sentence.order(:japanese)
    respond_to do |f|
      f.html
      f.json {render json:@sentences.tokens(params[:q])}
    end
  end

  def new
    last_sentence = current_user.sentences.order(:updated_at).last
    last_project_id = last_sentence.project.id if last_sentence
    @sentence = Sentence.new(project_id:last_project_id)
    @sentence.glossaries.build
  end

  def create
    @sentence = current_user.sentences.build(params[:sentence])
    #@sentence = Sentence.new(params[:sentence])
    if @sentence.save
      redirect_to @sentence 
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
