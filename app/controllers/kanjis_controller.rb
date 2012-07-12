class KanjisController < ApplicationController
  def show
    @kanji = Kanji.find(params[:id])
  end
end
