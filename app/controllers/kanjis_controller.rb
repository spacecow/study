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
      redirect_to @kanji, notice:updated(:kanji)
    else
    end
  end
end
