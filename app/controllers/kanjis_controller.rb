class KanjisController < ApplicationController
  load_and_authorize_resource

  def show
  end

  def index
    respond_to do |f|
      f.json {render json:@kanjis.tokens(params[:q])}
    end
  end

  def edit
  end

  def update
    if @kanji.update_attributes(params[:kanji]) 
      @kanji.similars.each do |similar|
        unless similar.similars.include?(@kanji)
          similar.similars << @kanji
        end
      end
      redirect_to @kanji
    end
  end
end
