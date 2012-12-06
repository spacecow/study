class SynonymGlossariesController < ApplicationController
  load_and_authorize_resource

  def destroy
    @synonym_glossary.destroy
    redirect_to Glossary.find(params[:main]), notice:deleted(:relation)
  end
end
