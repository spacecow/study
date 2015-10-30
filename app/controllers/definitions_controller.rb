class DefinitionsController < ApplicationController

  def show
  end

  def index
    respond_to do |f|
      f.json {render json:Definition.tokens(params[:q])}
    end
  end

  def edit
    @definition = repo.definition params[:id]
  end

  def update
    @definition = repo.definition params[:id]
    repo.update_definition @definition, params[:definition]
    redirect_to @definition.glossary
  end

end
