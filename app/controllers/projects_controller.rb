class ProjectsController < ApplicationController
  load_and_authorize_resource

  def new
  end

  def create
    if @project.save
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update_attributes(params[:project])
      redirect_to root_url
    else
      render :edit
    end
  end
end
