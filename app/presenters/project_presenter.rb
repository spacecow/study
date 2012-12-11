class ProjectPresenter < BasePresenter
  presents :project

  def form
    h.render 'form', project:project
  end
end
