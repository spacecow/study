class SentencesController < ApplicationController
  load_and_authorize_resource
  skip_load_resource :only => [:index,:new,:create]

  def show
  end

  def index
    @project_id = params[:project_id] unless params[:project] == '0'
    @sentences = Sentence.order(:japanese)
    if @project_id.to_i != 0
      @sentences = @sentences.where("project_id = ?", @project_id)
    else
      @sentences = @sentences.where("projects.name <> ?", 'Darkness').includes(:project)
    end
    @projects = [['All',0]] | Project.all.map{|e| [e.name, e.id]}
    respond_to do |f|
      f.html
      f.json {render json:@sentences.tokens(params[:q])}
    end
  end

  def new
    last_sentence = current_user.sentences.order(:updated_at).last
    last_project_id = last_sentence.project.id if last_sentence
    @sentence = Sentence.new(project_id:last_project_id)
    @sentence.glossaries.build
  end

  def create
    @sentence = current_user.sentences.build(params[:sentence])
    #@sentence = Sentence.new(params[:sentence])
    if @sentence.save
      redirect_to @sentence 
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @sentence.update_attributes(params[:sentence])
      redirect_to @sentence, notice:updated(:sentence)
    end
  end
end
