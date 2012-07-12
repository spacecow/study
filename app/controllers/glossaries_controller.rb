class GlossariesController < ApplicationController
  def show
    @glossary = Glossary.find(params[:id])
  end

  def index
    @glossaries = Glossary.order(:content)
    respond_to do |f|
      f.html
      f.json {render json:@glossaries.tokens(params[:q])}
    end
  end

  def new
    @glossary = Glossary.new
    @glossary.sentences.build
  end

  def create
    @glossary = Glossary.new(params[:glossary])
    if @glossary.save
      redirect_to new_glossary_path
    else
    end
  end

  def edit
    @glossary = Glossary.find(params[:id])
  end

  def update
    @glossary = Glossary.find(params[:id])
    if @glossary.update_attributes(params[:glossary])
      redirect_to glossaries_path
    else
    end
  end
end
