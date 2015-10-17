class LookupsController < ApplicationController

  def edit
    @lookup = Lookup.find params[:id]
  end

  def update
    @lookup = Lookup.find params[:id]
    if @lookup.update_attributes(params[:lookup])
    else
      render :edit
    end 
  end

end
