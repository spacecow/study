class LocalesController < ApplicationController
  def index
    @locales = Locale.order(:name)
    respond_to do |f|
      f.json {render json:@locales.tokens(params[:q])}
    end
  end
end
