class SimilarGlossariesController < ApplicationController
  load_and_authorize_resource

  def destroy
    @similar_glossary.destroy
    redirect_to Glossary.find(params[:main]), notice:deleted(:relation)
  end
end
