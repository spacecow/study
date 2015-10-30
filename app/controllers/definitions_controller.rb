class DefinitionsController < ApplicationController

  def index
    respond_to do |f|
      f.json {render json:Definition.tokens(params[:q])}
    end
  end
end
