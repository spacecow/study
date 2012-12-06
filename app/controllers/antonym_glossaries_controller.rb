class AntonymGlossariesController < ApplicationController
  load_and_authorize_resource

  def destroy
    @antonym_glossary.destroy
    redirect_to Glossary.find(params[:main]), notice:deleted(:relation)
  end
end
