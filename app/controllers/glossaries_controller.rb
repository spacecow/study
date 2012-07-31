class GlossariesController < ApplicationController
  load_and_authorize_resource
  skip_load_resource :only => :index

  def show
  end

  def index
    @glossaries = Glossary.order(:content)
    respond_to do |f|
      f.html
      f.json {render json:@glossaries.tokens(params[:q])}
    end
  end

  def new
    @glossary.sentences.build
  end

  def create
    if @glossary.save
      redirect_to new_glossary_path
    else
    end
  end

  def edit
  end

  def update
    if @glossary.update_attributes(params[:glossary])
      redirect_to glossaries_path
    else
    end
  end
end
