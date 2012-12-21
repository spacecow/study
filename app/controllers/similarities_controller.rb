class SimilaritiesController < ApplicationController
  load_and_authorize_resource

  def destroy
    @similarity.destroy
    redirect_to Kanji.find(params[:main_id])
  end
end
